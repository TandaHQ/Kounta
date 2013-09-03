require "oj"

module Kounta
	module REST
		module API
			module Utils

				def load_hash_from_file(filename)
					Oj.load(File.read("#{Kounta.root}/spec/fixtures/#{filename}"), symbol_keys: true)
				end

				def objects_from_response(klass, ids, reponses)
					reponses.map {|response| klass.new(*ids, response) }
				end

			end
		end
	end
end