require_relative "resource"
require_relative "product"

module Kounta

	class PriceList < Kounta::Resource
		property :parent_id
		property :name
		property :products
		
		coerce_key :products, Product
	end

end