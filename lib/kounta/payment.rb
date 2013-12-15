module Kounta

	class Payment < Kounta::Resource
		property :company_id
		property :order_id
		property :method_id
		property :amount
		property :ref
		property :method
		property :number

		def resource_path
			{companies: company_id, orders: order_id, payments: id}
		end

	end

end