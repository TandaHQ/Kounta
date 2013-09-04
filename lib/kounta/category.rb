require_relative "resource"

module Kounta

	class Category < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data[:id].to_i
		end

		def name
			@data[:name]
		end

		def description
			@data[:description]
		end

	end

end