require_relative "resource"

module Kounta

	class Company < Kounta::Resource
		property :name
		property :shipping_address
		property :postal_address
		property :addresses
		property :business_number
		property :contact_staff_member
		property :image
		property :website
		property :currency
		property :timezone
		property :sites
		property :registers

		def initialize(hash={})
			if hash.empty?
				super(client.perform({:companies => "me"}, :get))
			else
				super(hash)
			end
		end

		def categories
			client.objects_from_response(Kounta::Category, :get, {companies: id, categories: nil})
		end

		def category(category_id)
			client.object_from_response(Kounta::Category, :get, {companies: id, categories: category_id})
		end

		def customers
			client.objects_from_response(Kounta::Customer, :get, {companies: id, customers: nil})
		end

		def customer(customer_id)
			client.object_from_response(Kounta::Customer, :get, {companies: id, customers: customer_id})
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