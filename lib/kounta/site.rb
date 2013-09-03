require_relative "rest/api/product"

module Kounta

	class Site
		include Kounta::REST::API::Product

		attr_reader :company_id

		def initialize(company_id, data)
			@company_id = company_id
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

		def products
			company_site_products(@company_id, id)
		end

		def product(product_id)
			company_site_product(@company_id, id, product_id)
		end

	end

end