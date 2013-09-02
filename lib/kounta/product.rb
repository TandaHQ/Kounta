require_relative "rest/api/product"

module Kounta

	class Product
		include Kounta::REST::API::Product

		def initialize(data)
			@data = data
		end

		def id
			@data["id"].to_i
		end

		def name
			@data["name"]
		end

		def code
			@data["code"]
		end

		def description
			@data["description"]
		end

		def barcode
			@data["barcode"]
		end

		def tags
			@data["tags"]
		end

		def tags_include?(name)
			tags.include?(name)
		end

		def categories
			product_categories(id)
		end

	end

end