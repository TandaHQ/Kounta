require_relative "utils"
require_relative "../../company"

module Kounta
	module REST
		module API
			module Company
				include Kounta::REST::API::Utils

				# return the company at id, or return the authenticated company
				# @id (optional) of the company you want to fetch details for
				def company(id=nil)
					if id
						Kounta::Company.new load_hash_from_file('company.json')
					else
						Kounta::Company.new load_hash_from_file('company.json')
					end
				end

				def company_category(category_id)
					Kounta::Company.new load_hash_from_file('category.json')
				end

				def company_product(product_id)
					Kounta::Company.new load_hash_from_file('category.json')
				end

			end
		end
	end
end	