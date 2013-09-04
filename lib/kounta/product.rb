require_relative "resource"

module Kounta

	class Product < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data[:id].to_i
		end

		def company_id
			@data[:company_id].to_i
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
			client.objects_from_response(Kounta::Category, :get, {companies: company_id, products: id, categories: nil})
		end

	end

end