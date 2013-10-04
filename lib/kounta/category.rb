module Kounta

	class Category < Kounta::Resource
		property :company_id
		property :name
		property :description
		property :image
		property :products

		private

		def resource_path
			{companies: company_id, categories: id}
		end		

	end

end