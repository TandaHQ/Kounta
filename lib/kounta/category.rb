require "kounta/rest/client"

module Kounta

	class Category

		def initialize(data)
			@data = data
		end

		def id
			@data["id"].to_i
		end

		def name
			@data["name"]
		end

		def description
			@data["description"]
		end

		def products
			
		end

	end

end