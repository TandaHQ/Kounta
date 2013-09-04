require 'oj'
require 'uri'

module Kounta
	module REST
		class Client

			DOMAIN = "http://www.kounta.com"
			VERSION = "v1"
			PATH = "#{DOMAIN}/#{VERSION}"
			FORMAT = "json"

			# TODO - set settings

			def initialize

			end

			def objects_from_response(klass, request_method, url_hash, options={})
				perform(url_hash, request_method, options).map { |response|
					klass.new(response)
				}
			end

			def object_from_response(klass, request_method, url_hash, options={})
				klass.new(perform(url_hash, request_method, options))
			end

			def perform(url_hash, request_method, options={})
				load_hash_from_file( url_to_filesystem(url_from_hash(url_hash)))
			end

			def url_to_filesystem(url)
				"#{Kounta.root}/spec/fixtures#{URI(url).path}"
			end

			def url_from_hash(url_hash)
				"#{Client::PATH}/#{path_from_hash(url_hash)}.#{Client::FORMAT}"
			end

			def path_from_hash(url_hash)
				url_hash.map{ |key, value| value ? "#{key}/#{value}" : "#{key}" }.join('/')
			end

			def load_hash_from_file(filename)
				Oj.load(File.read(filename), symbol_keys: true)
			end

		end
	end
end