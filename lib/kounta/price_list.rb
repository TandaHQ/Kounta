require_relative "resource"
require_relative "price_list_product"

module Kounta

	class PriceList < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data['id'] ? @data['id'].to_i : nil
		end

		def name
			@data['name']
		end

		def price_list_products
			@data['products'].map { |price_list_product_data| PriceListProduct.new(price_list_product_data) }
		end

	end

end