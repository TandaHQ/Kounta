require_relative "resource"

module Kounta

	class Address < Kounta::Resource

		def initialize(data=nil)
			@data = data
		end

		def id
			@data['id'] ? @data['id'].to_i : nil
		end

		def people_id
			@data['people_id'] ? @data['people_id'].to_i : nil
		end

		def lines
			@data['lines']
		end

		def lines= (value)
			@data['lines'] = value
		end

		def city
			@data['city']
		end

		def city= (value)
			@data['city'] = value
		end

		def zone
			@data['zone']
		end

		def zone= (value)
			@data['zone'] = value
		end

		def postal_code
			@data['postal_code']
		end

		def postal_code= (value)
			@data['postal_code'] = value
		end

		def country
			@data['country']
		end

		def country= (value)
			@data['country'] = value
		end

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