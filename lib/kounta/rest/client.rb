require_relative "api/company"
require_relative "api/category"
require_relative "api/product"

module Kounta
	module REST
		class Client
			include Kounta::REST::API::Company
			include Kounta::REST::API::Category
			include Kounta::REST::API::Product

			def initialize
			end

		end
	end
end