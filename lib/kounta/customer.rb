require_relative "resource"

module Kounta

	class Customer < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data['id'].to_i
		end

		def first_name
			@data['first_name']
		end

		def last_name
			@data['last_name']
		end

		def name
			"#{first_name} #{last_name}"
		end

		def email
			@data['primary_email_address']
		end

	end

end