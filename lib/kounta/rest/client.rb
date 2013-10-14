require 'faraday'
require 'faraday_middleware'

module Kounta
	module REST
		class Client

			API = "https://api.kounta.com/v1"
			FORMAT = :json

			def initialize
				raise Kounta::MissingOauthDetails unless Kounta.oauth_client_token

				@conn = Faraday.new(:url => API) do |faraday|
					faraday.request :url_encoded
					faraday.response FORMAT
					faraday.adapter Faraday.default_adapter
				end
			end

			def path_from_hash(url_hash)
				url_hash.map{ |key, value| value ? "#{key}/#{value}" : "#{key}" }.join('/')
			end

			def perform(url_hash, request_method, options={})
				@conn.send(request_method.to_sym, "#{path_from_hash(url_hash)}.#{FORMAT.to_s}", options).body
			end

			def objects_from_response(klass, request_method, url_hash, options={})
				perform(url_hash, request_method, options).map { |response| klass.new(response) }
			end

			def object_from_response(klass, request_method, url_hash, options={})
				klass.new( perform(url_hash, request_method, options) )
			end

		end
	end
end