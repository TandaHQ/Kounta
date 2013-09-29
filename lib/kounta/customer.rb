require_relative "resource"

module Kounta

	class Customer < Kounta::Resource
		property :company_id, :required => true
		property :people_id, :required => true
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

		def addresses
			client.objects_from_response(Kounta::Address, :get, {companies: company_id, customers: id, addresses: nil})
		end

		def address(address_id)
			client.object_from_response(Kounta::Address, :get, {companies: company_id, customers: id, addresses: address_id})
		end

		private

		def resource_path
			{companies: company_id, customers: id}
		end	

	end

end