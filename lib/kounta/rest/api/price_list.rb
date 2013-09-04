require_relative "utils"
require_relative "../../price_list"

module Kounta
	module REST
		module API
			module PriceList
				include Kounta::REST::API::Utils

				def price_list(company_id, price_list_id)
					Kounta::PriceList.new(company_id, load_hash_from_file('price_list.json'))
				end

			end
		end
	end
end	