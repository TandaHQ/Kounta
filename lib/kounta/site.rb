require_relative "resource"

module Kounta

	class Site < Kounta::Resource
		attr_reader :company_id

		def initialize(company_id, data)
			@company_id = company_id
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

		def products
			client.company_site_products(@company_id, id)
		end

		def product(product_id)
			client.company_site_product(@company_id, id, product_id)
		end

		def categories
			client.company_site_categories(@company_id, id)
		end

		def category(category_id)
			client.company_site_category(@company_id, id, category_id)
		end

		def company
			client.company(@company_id)
		end

	end

end