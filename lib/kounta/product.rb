require_relative "resource"

module Kounta

	class Product < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data[:id].to_i
		end

		def name
			@data[:name]
		end

		def code
			@data[:code]
		end

		def description
			@data[:description]
		end

		def tags
			@data[:tags]
		end

		def tags_include?(name)
			tags.include?(name)
		end

		def categories
			
		end

	end

end