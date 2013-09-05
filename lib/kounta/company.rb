require_relative "resource"

module Kounta

	class Company < Kounta::Resource

		def initialize(data=nil)
			if data
				@data = data
			else
				@data = client.perform({:companies => "me"}, :get)
			end
		end

		def id
			@data['id'].to_i
		end

		def categories
			client.objects_from_response(Kounta::Category, :get, {companies: id, categories: nil})
		end

		def category(category_id)
			client.object_from_response(Kounta::Category, :get, {companies: id, categories: category_id})
		end

		def products
			client.objects_from_response(Kounta::Product, :get, {companies: id, products: nil})
		end

		def product(product_id)
			client.object_from_response(Kounta::Product, :get, {companies: id, products: product_id})
		end

		def sites
			client.objects_from_response(Kounta::Site, :get, {companies: id, sites: nil})
		end

		def site(site_id)
			client.object_from_response(Kounta::Site, :get, {companies: id, sites: site_id})
		end

		def price_lists
			client.objects_from_response(Kounta::PriceList, :get, {companies: id, price_lists: nil})
		end

		def price_list(price_list_id)
			client.object_from_response(Kounta::PriceList, :get, {companies: id, price_lists: price_list_id})
		end

		def base_price_list
			client.object_from_response(Kounta::PriceList, :get, {companies: id, price_lists: 'base'})
		end

	end

end