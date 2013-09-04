require_relative "api/company"
require_relative "api/category"
require_relative "api/product"
require_relative "api/site"
require_relative "api/price_list"

module Kounta
	module REST
		class Client
			include Kounta::REST::API::Company
			include Kounta::REST::API::Category
			include Kounta::REST::API::Product
			include Kounta::REST::API::Site
			include Kounta::REST::API::PriceList

			def initialize

			end

		end
	end
end