require_relative "resource"
require_relative "tax"

module Kounta

	class Product < Kounta::Resource
		property :company_id, :required => true
		property :code
		property :barcode
		property :stock
		property :name
		property :description
		property :tags
		property :image
		property :unit_price
		property :cost_price
		property :taxes

		coerce_key :taxes, Kounta::Tax

		def to_hash
			{
				name: name,
				description: description
			}
		end

		def tags_include?(name)
			tags.any?{ |s| s.casecmp(name) == 0 }
		end

		def categories
			client.objects_from_response(Kounta::Category, :get, {companies: company_id, products: id, categories: nil})
		end

		private

		def resource_path
			{companies: company_id, products: id}
		end

	end

end