require_relative "resource"
require_relative "address"

module Kounta

	class Customer < Kounta::Resource
		property :company_id
		property :people_id
		property :first_name
		property :last_name
		property :primary_email_address
		property :description
		property :email_addresses
		property :phone
		property :mobile
		property :fax
		property :shipping_address
		property :postal_address
		property :addresses
		property :image
		property :tags

		has_one :address, Kounta::Address, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, addresses: item_id} }
		has_many :addresses, Kounta::Address, lambda { |klass| {companies: klass.id, addresses: nil} }

		def name
			"#{first_name} #{last_name}"
		end

		def to_hash
			{
				first_name: first_name,
				last_name: last_name,
				primary_email_address: primary_email_address
			}
		end

		private

		def resource_path
			{companies: company_id, customers: id}
		end	

	end

end