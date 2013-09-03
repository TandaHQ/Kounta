require_relative "resource"

module Kounta

	class Product < Kounta::Resource
		attr_reader :company_id
		attr_reader :site_id

		def initialize(company_id, site_id, data)
			@company_id = company_id
			@site_id = site_id
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
			client.company_product_categories(@company_id, id)
		end

	end

end