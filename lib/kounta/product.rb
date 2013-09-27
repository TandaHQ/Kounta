require_relative "resource"

module Kounta

	class Product < Kounta::Resource

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

		def name= (value)
			@data['name'] = value
		end

		def description
			@data['description']
		end

		def description= (value)
			@data['description'] = value
		end

		def tags
			@data['tags']
		end

		def image
			@data['image']
		end

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

		def missing_required_attributes?
			!company_id
		end

		def resource_path
			{companies: company_id, products: id}
		end

	end

end