require_relative "resource"

module Kounta

	class Category < Kounta::Resource

		property :company_id, :required => true
		property :name
		property :description
		property :image
		property :products

		def to_hash
			{
				name: name,
				description: description
			}
		end

		private

		def missing_required_attributes?
			!company_id
		end

		def resource_path
			{companies: company_id, categories: id}
		end		

	end

end