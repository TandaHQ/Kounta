require_relative "resource"

module Kounta

	class Company < Kounta::Resource

		# If we don't pass in data to the company, assume we mean the company associated with
		# these oauth details.
		# @data hash of company data
		def initialize(data=nil)
			@data = data ? data : client.company.to_h
		end

		def id
			@data[:id].to_i
		end

		def to_h
			{
				id: id
			}
		end

		def categories
			client.company_categories(id)
		end

		def category(category_id)
			client.company_category(id, category_id)
		end

		def sites
			client.company_sites(id)
		end

		def site(site_id)
			client.company_site(id, site_id)
		end

		def price_list(price_list_id)
			client.price_list(id, price_list_id)
		end

	end

end