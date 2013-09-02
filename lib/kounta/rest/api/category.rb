require_relative "utils"
require_relative "../../category"
require_relative "../../product"

module Kounta
	module REST
		module API
			module Category
				include Kounta::REST::API::Utils

				def company_categories(company_id)
					objects_from_response(Kounta::Category, [company_id], load_hash_from_file('categories.json'))
				end

				def company_category(company_id, id)
					Kounta::Category.new(company_id, load_hash_from_file('category.json'))
				end

			end
		end
	end
end	