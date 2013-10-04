require_relative "customer"
require_relative "line"
require_relative "payment"

module Kounta

	class Order < Kounta::Resource
		property :company_id
		property :status
		property :customer
		property :register_id
		property :site_id
		property :lines
		property :payments
		property :callback_uri
		property :placed_at
		property :fulfil_at
		property :notes

		coerce_key :customer, Kounta::Customer
		coerce_key :lines, Kounta::Line
		coerce_key :payments, Kounta::Payment

		def to_hash
			{
				status: status,
				notes: notes,
				customer_id: customer_id,
				site_id: site_id
				lines: lines.map {|line| line.to_hash },
				payments: payments.map {|payment| payment.to_hash }
				callback_uri: callback_uri,
				placed_at: placed_at
				fulfil_at: fulfil_at
			}
		end

		private

		def resource_path
			{companies: company_id, orders: id}
		end

	end

end