require_relative "utils"
require_relative "../../site"
require_relative "../../product"

module Kounta
	module REST
		module API
			module Site
				include Kounta::REST::API::Utils

				def company_sites(company_id)
					objects_from_response(Kounta::Site, [company_id], load_hash_from_file('sites.json'))
				end

				def company_site(company_id, id)
					Kounta::Site.new(company_id, load_hash_from_file('site.json'))
				end

			end
		end
	end
end	