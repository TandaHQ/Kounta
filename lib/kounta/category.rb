module Kounta

	class Category
		attr_reader :company_id

		def initialize(company_id, data)
			@company_id = company_id
			@data = data
		end

		def id
			@data["id"].to_i
		end

		def name
			@data["name"]
		end

		def description
			@data["description"]
		end

	end

end