require_relative "resource"

module Kounta

	class Product < Kounta::Resource

		def initialize(data)
			@data = data
		end

		def id
			@data['id'].to_i if @data['id']
		end

		def company_id
			@data['company_id'].to_i if @data['company_id']
		end

		def name
			@data['name']
		end

		def description
			@data['description']
		end

		def tags
			@data['tags']
		end

		def to_hash
			{
				name: name,
				description: description,
				tags: tags
			}
		end

		def tags_include?(name)
			tags.any?{ |s| s.casecmp(name) == 0 }
		end

		def categories
			client.objects_from_response(Kounta::Category, :get, {companies: company_id, products: id, categories: nil})
		end

		private

		def required_ids
			!!company_id
		end

		def save_path
			{companies: company_id, products: id}
		end

		def create_path
			{companies: company_id, products: nil}
		end

	end

end