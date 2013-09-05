require_relative "resource"

module Kounta

	class Site < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data['id'].to_i
		end

		def company_id
			@data['company_id'].to_i
		end

		def name
			@data['name']
		end

		def code
			@data['code']
		end

		def products
			client.objects_from_response(Kounta::Product, :get, {companies: company_id, sites: id, products: nil})
		end

		def product(product_id)
			client.object_from_response(Kounta::Product, :get, {companies: company_id, sites: id, products: product_id})
		end

		def categories
			client.objects_from_response(Kounta::Category, :get, {companies: company_id, sites: id, categories: nil})
		end

		def category(category_id)
			client.object_from_response(Kounta::Category, :get, {companies: company_id, sites: id, categories: category_id})
		end

	end

end