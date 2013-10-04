require_relative "resource"

module Kounta

	class Address < Kounta::Resource
		property :company_id
		property :people_id
		property :lines
		property :city
		property :zone
		property :postal_code
		property :country

		private

		def resource_path
			{people: people_id, addresses: id}
		end

	end

end