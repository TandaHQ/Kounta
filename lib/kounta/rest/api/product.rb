require "kounta/rest/api/utils"
require "kounta/category"
require "kounta/product"

module Kounta
	module REST
		module API
			module Product
				include Kounta::REST::API::Utils

				def products
					load_hash_from_file('products.json').map { |response| Kounta::Product.new(response) }
				end

				def product(product_id)
					Kounta::Product.new load_hash_from_file('product.json')
				end

				def product_categories(product_id)
					load_hash_from_file('categories.json').map { |response| Kounta::Category.new(response) }
				end

			end
		end
	end
end