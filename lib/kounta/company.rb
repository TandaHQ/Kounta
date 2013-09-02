require_relative "rest/api/category"
require_relative "rest/api/site"

module Kounta

	class Company
		include Kounta::REST::API::Category
		include Kounta::REST::API::Site

		def initialize(data)
			@data = data
		end

		def id
			@data["id"].to_i
		end

		def categories
			company_categories(id)
		end

		def category(category_id)
			company_category(id, category_id)
		end

		def sites
			company_sites(id)
		end

		def site(site_id)
			company_site(id, site_id)
		end

	end

end