require 'faraday'
require 'faraday_middleware'

module Kounta
	module REST
		class Client

			DOMAIN = "http://www.kounta.com"
			VERSION = "v1"
			PATH = "#{DOMAIN}/#{VERSION}"
			FORMAT = "json"

			# TODO - set settings

			def initialize
				@conn = Faraday.new(:url => PATH) do |faraday|
					faraday.request :url_encoded
					faraday.response :json
					faraday.response :logger
					faraday.adapter Faraday.default_adapter
				end
			end

			def objects_from_response(klass, request_method, url_hash, options={})
				perform(url_hash, request_method, options).map { |response| klass.new(response) }
			end

			def object_from_response(klass, request_method, url_hash, options={})
				klass.new( perform(url_hash, request_method, options) )
			end

			def perform(url_hash, request_method, options={})
				@conn.send(request_method.to_sym, "#{path_from_hash(url_hash)}.#{FORMAT}", options).body
			end

			def path_from_hash(url_hash)
				url_hash.map{ |key, value| value ? "#{key}/#{value}" : "#{key}" }.join('/')
			end

		end
	end
end