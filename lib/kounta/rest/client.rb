require 'faraday'
require 'faraday_middleware'
require 'oauth2'
require 'base64'
require 'oj'

module Kounta
	module REST
		class Client

			def initialize
				raise Kounta::Errors::MissingOauthDetails unless has_required_oauth_details?
				@conn = OAuth2::AccessToken.new(client, Kounta.client_token, {:refresh_token => Kounta.client_refresh_token})
			end

			def client
				@oauth_client ||= OAuth2::Client.new(
					Kounta.client_id,
					Kounta.client_secret,
					:site => Kounta::SITE_URI,
					:authorize_url => Kounta::AUTHORIZATION_URI,
					:token_url => Kounta::TOKEN_URI
				)
			end

			def path_from_hash(url_hash)
				url_hash.map{ |key, value| value ? "#{key}/#{value}" : "#{key}" }.join('/')
			end

			def perform(url_hash, request_method, options={})
				begin
					response = @conn.send(request_method.to_sym, "#{path_from_hash(url_hash)}.#{FORMAT.to_s}", options)
				rescue OAuth2::Error => ex
					if ex.message.include? 'The access token provided has expired'
						puts "--- refreshing token"
						@conn = OAuth2::AccessToken.from_hash(client, :refresh_token => Kounta.client_refresh_token).refresh!
						retry
					end
				end
				raise Kounta::Errors::APIError, response.body['error_description'] if response.status != 200 && response.status != 201
				response.parsed
			end

			def objects_from_response(klass, request_method, url_hash, options={})
				perform(url_hash, request_method, options).map { |response| klass.new(response) }
			end

			def object_from_response(klass, request_method, url_hash, options={})
				klass.new( perform(url_hash, request_method, options) )
			end

			private

				def has_required_oauth_details?
					Kounta.client_id && Kounta.client_secret && Kounta.client_token && Kounta.client_refresh_token
				end

		end
	end
end