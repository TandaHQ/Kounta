require_relative "resource"

module Kounta

	class Customer < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data['id'] ? @data['id'].to_i : nil
		end

		def company_id
			@data['company_id'] ? @data['company_id'].to_i : nil
		end

		def first_name
			@data['first_name']
		end

		def first_name= (value)
			@data['first_name'] = value
		end

		def last_name
			@data['last_name']
		end

		def last_name= (value)
			@data['last_name'] = value
		end

		def name
			"#{first_name} #{last_name}"
		end

		def email
			@data['primary_email_address']
		end

		def to_hash
			{
				first_name: first_name,
				last_name: last_name,
				email: email
			}
		end

		private

		def missing_required_attributes?
			!company_id
		end

		def resource_path
			{companies: company_id, customers: id}
		end	

	end

end