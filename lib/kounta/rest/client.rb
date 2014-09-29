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
				rescue OAuth2::Error => ex
					if ex.message.include? 'The access token provided has expired'
						@auth_connection = refreshed_token
						retry
					end
					
					#raise Kounta::Errors::APIError.new(ex.message)
				end
				response
			end

			def objects_from_response(klass, request_method, url_hash, options={})
				response = perform(url_hash, request_method, options)
				page_count = response.headers["x-pages"].to_i

				if page_count > 1
					results = []
					page_count.times { |page_number|
						response = perform(url_hash, request_method, options.merge!(:headers => {'X-Page' => (page_number).to_s}))
						results = results + response.parsed
					}
					results.map { |item| klass.new(item) }
				else
					response.parsed.map { |item| klass.new(item) }
				end
			end

			def object_from_response(klass, request_method, url_hash, options={})
				response = perform(url_hash, request_method, options)
				klass.new(response.parsed)
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