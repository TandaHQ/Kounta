require "kounta/rest/api/utils"
require "kounta/category"

module Kounta
	module REST
		module API
			module Category
				include Kounta::REST::API::Utils

				def categories
					load_hash_from_file('categories.json').map { |response| Kounta::Category.new(response) }
				end

			end
		end
	end
end