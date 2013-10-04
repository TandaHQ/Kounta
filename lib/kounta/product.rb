module Kounta

	class Product < Kounta::Resource
		property :company_id
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

		has_many :categories, Kounta::Category, lambda { |klass| {companies: klass.company_id, products: klass.id, categories: nil} }
		coerce_key :taxes, Kounta::Tax

		def tags_include?(name)
			tags.any?{ |s| s.casecmp(name) == 0 }
		end

		def resource_path
			{companies: company_id, products: id}
		end

	end

end