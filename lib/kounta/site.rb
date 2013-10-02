require_relative "resource"

module Kounta

	class Site < Kounta::Resource
		property :company_id
		property :name
		property :code

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

		def addresses
			client.objects_from_response(Kounta::Address, :get, {companies: company_id, sites: id, addresses: nil})
		end

		def address(address_id)
			client.object_from_response(Kounta::Address, :get, {companies: company_id, sites: id, addresses: address_id})
		end

	end

end