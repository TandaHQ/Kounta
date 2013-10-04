module Kounta

	class Line < Kounta::Resource
		property :company_id
		property :order_id
		property :product_id
		property :number
		property :quantity
		property :notes
		property :price_variation

		private

		def resource_path
			{companies: company_id, orders: order_id, lines: id}
		end

	end

end