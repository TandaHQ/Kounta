require "oj"

module Kounta
	module REST
		module API
			module Utils

				def load_hash_from_file(filename)
					Oj.load(File.read("#{Kounta.root}/spec/fixtures/#{filename}"))
				end

			end
		end
	end
end