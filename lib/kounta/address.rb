require_relative "resource"

module Kounta

	class Address < Kounta::Resource
		include Hashie::Extensions::Coercion

		property :people_id, :required => true
		property :lines
		property :city
		property :zone
		property :postal_code, :required => true
		property :country, :required => true

		def to_hash
			{
				lines: lines,
				city: city,
				zone: zone,
				postal_code: postal_code,
				country: country
			}
		end

		private

		def missing_required_attributes?
			!people_id
		end

		def resource_path
			{people: people_id, addresses: id}
		end

	end

end