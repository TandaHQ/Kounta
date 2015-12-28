require 'oauth2'
require 'oj'
require 'faraday_middleware'

module Kounta
    module REST
        class Client
      def initialize(options)
        @redirect_uri         = options[:redirect_uri]
        @consumer             = options[:consumer]
        @access_token         = options[:access_token]
        @refresh_token        = options[:refresh_token]
        @client               = OAuth2::Client.new(@consumer[:key], @consumer[:secret], {
                    :site => Kounta::SITE_URI,
                    :authorize_url => Kounta::AUTHORIZATION_URI,
                    :token_url => Kounta::TOKEN_URI
        }) do |faraday|
                    faraday.request :json
                    faraday.use Faraday::Request::UrlEncoded
                    faraday.use Faraday::Response::Logger if Kounta.enable_logging
                    faraday.adapter Faraday.default_adapter
                end
      end

      def authenticated?
        @access_token.present?
      end

      def get_access_code_url(params = {})
        # Kounta's API seems to require the `state` param (can't find documentation on it anywhere)
        # learn more about it: http://homakov.blogspot.com.au/2012/07/saferweb-most-common-oauth2.html
        @client.auth_code.authorize_url(params.merge(redirect_uri: @redirect_uri, state: SecureRandom.hex(24)))
      end

      def get_access_token(access_code)
        @token = @client.auth_code.get_token(access_code, redirect_uri: @redirect_uri)
        @access_token = @token.token
        @expires_at = @token.expires_at
        @refresh_token = @token.refresh_token
        @token
      end

      def company(hash = {})
        @company ||= Kounta::Company.new(self, hash)
      end

            def path_from_hash(url_hash)
        # TODO: there's probably a more correct way of doing this encoding
                url_hash.map{ |key, value| value ? "#{key}/#{value.to_s.gsub("-", "%2D")}" : "#{key}" }.join('/')
            end

            def perform(url_hash, request_method, options={})
                begin
                    if url_hash.kind_of? Hash
                        response = oauth_connection.request(request_method, "#{path_from_hash(url_hash)}.#{FORMAT.to_s}", options)
                    else
                        response = oauth_connection.request(request_method, url_hash, options)
                    end
                rescue Exception => ex
                    if !ex.message.nil? && (ex.message.include?('The access token provided has expired') || ex.message.include?('expired') || ex.message.include?('invalid'))
                        @auth_connection = refreshed_token
                        retry
                    end

                    raise Kounta::Errors::RequestError.new(response.nil? ? 'Unknown Status' : response.status)
                end

                unless response
                    raise Kounta::Errors::RequestError.new('Unknown Status')
                end

                response
            end

            def objects_from_response(klass, request_method, url_hash, options={})
                response = perform(url_hash, request_method, options)
                last_page = response.headers["x-pages"].to_i - 1
                results = response.parsed

                # Already got page 0, start at page 1
                (1..last_page).each { |page_number|
                    response = perform(url_hash, request_method, options.merge!(:headers => {'X-Page' => (page_number).to_s}))
                    results = results + response.parsed
                }

                results.map { |item| klass.new(item) }
            end

            def object_from_response(klass, request_method, url_hash, options={})
                response = perform(url_hash, request_method, options)
                klass.new(response.parsed)
            end

            def objects_from_response_in_time_range(klass, request_method, url_hash, options={})
                if options.has_key?(:params) && (options[:params].has_key?(:created_gte) ^ options[:params].has_key?(:created_gt)) &&
                            (options[:params].has_key?(:created_lte) ^ options[:params].has_key?(:created_lt))
                    params = options[:params]
                    start_equal = params.has_key?(:created_gte)
                    finish_equal = params.has_key?(:created_lte)
                    start = (start_equal ? params[:created_gte] : params[:created_gt]).to_time
                    finish = (finish_equal ? params[:created_lte] : params[:created_lt]).to_time

                    params.except!(:created_gte, :created_gt, :created_lte, :created_lt)

                    start_date = start.to_date
                    finish_date = finish.to_date

                    start = start.to_i
                    finish = finish.to_i

                    results = []

                    options[:params] = params.merge(created_gte: start_date, created_lte: finish_date)
                    response = perform(url_hash, request_method, options)
                    last_page = response.headers["x-pages"].to_i - 1
                    parsed = response.parsed.map{|o| o['created_at_epoch'] = Time.parse(o['created_at']).to_i; o}

                    response_start = parsed.last['created_at_epoch']
                    response_finish = parsed.first['created_at_epoch']

                    # all current and future responses will be before the required start
                    return results if response_finish < start

                    # reverse to order them in ascending order
                    results = results + filter_responses_in_date_range(parsed.reverse, start, finish)

                    # all future responses will be before the required start
                    return results if response_start < start

                    (1..last_page).each{ |page_number|
                        response = perform(url_hash, request_method, options.merge!(headers: {'X-Page' => (page_number).to_s}))
                        parsed = response.parsed.map{|o| o['created_at_epoch'] = Time.parse(o['created_at']).to_i; o}

                        response_start = parsed.last['created_at_epoch']
                        response_finish = parsed.first['created_at_epoch']

                        # all current and future responses will be before the required start
                        break if response_finish < start

                        # reverse to order them in ascending order
                        results = results + filter_responses_in_date_range(parsed.reverse, start, finish)

                        # all future responses will be before the required start
                        break if response_start < start
                    }

                    # reverse to under reverses used to order them in ascending order
                    results.reverse.map { |item| klass.new(item) }
                else
                    raise ArgumentError.new("url_has must contain exactly one of [:created_gte, :created_gt] and exactly one of [:created_lte, :created_lt]")
                end
            end

            def filter_responses_in_date_range(parsed_responses, start, finish)
                start_index = parsed_responses.index {|response| response['created_at_epoch'] >= start} || parsed_responses.length - 1
                finish_index = parsed_responses.rindex{|response| response['created_at_epoch'] <= finish} || 0
                parsed_responses[start_index..finish_index]
            end

            private

                def oauth_connection
            if @refresh_token
              @auth_connection ||= OAuth2::AccessToken.new(@client, @access_token, {
                :refresh_token => @refresh_token
              }).refresh!
            else
              @auth_connection ||= OAuth2::AccessToken.new(@client, @access_token)
            end
                end

                def refreshed_token
                    OAuth2::AccessToken.from_hash(@client, :refresh_token => @refresh_token).refresh!
                end

        end
    end
end
