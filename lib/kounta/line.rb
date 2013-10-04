module Kounta

	class Line < Kounta::Resource
		property :company_id
		property :order_id
		property :product_id
		property :number
		property :quantity
		property :notes
		property :price_variation
		property :product
		property :unit_price
		property :unit_tax

		coerce_key :product, Kounta::Product

		def resource_path
			{companies: company_id, orders: order_id, lines: id}
		end

	end

end