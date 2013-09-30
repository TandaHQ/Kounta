require_relative "resource"

module Kounta

	class Tax < Kounta::Resource
		property :company_id, :required => true
		property :code
		property :name
		property :rate

		def to_hash
			{
				code: code,
				name: name,
				rate: rate
			}
		end

		private

		def resource_path
			{companies: company_id, taxes: id}
		end

	end

end