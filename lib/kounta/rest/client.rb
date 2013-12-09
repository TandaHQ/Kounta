require 'oauth2'
require 'oj'
require 'faraday_middleware'

module Kounta
	module REST
		class Client

			def initialize
				raise Kounta::Errors::MissingOauthDetails unless has_required_oauth_details?
				@conn = OAuth2::AccessToken.new(client, Kounta.client_token, {:refresh_token => Kounta.client_refresh_token})
			end

			def client
				@oauth_client ||= OAuth2::Client.new(Kounta.client_id, Kounta.client_secret, {
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

			def path_from_hash(url_hash)
				url_hash.map{ |key, value| value ? "#{key}/#{value}" : "#{key}" }.join('/')
			end

			def perform(url_hash, request_method, options={})
				begin
					if url_hash.kind_of? Hash
						response = @conn.request(request_method, "#{path_from_hash(url_hash)}.#{FORMAT.to_s}", options)
					else
						response = @conn.request(request_method, url_hash, options)
					end
				rescue OAuth2::Error => ex
					if ex.message.include? 'The access token provided has expired'
						@conn = refreshed_token
						retry
					end
					raise Kounta::Errors::APIError.new(ex.message)
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

				def has_required_oauth_details?
					Kounta.client_id && Kounta.client_secret && Kounta.client_token && Kounta.client_refresh_token
				end

				def refreshed_token
					OAuth2::AccessToken.from_hash(client, :refresh_token => Kounta.client_refresh_token).refresh!
				end

		end
	end
end