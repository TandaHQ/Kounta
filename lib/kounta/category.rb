require_relative "resource"

module Kounta

	class Category < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data['id'] ? @data['id'].to_i : nil
		end

		def company_id
			@data['company_id'] ? @data['company_id'].to_i : nil
		end

		def name
			@data['name']
		end

		def description
			@data['description']
		end

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