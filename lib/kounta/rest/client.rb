require "kounta/rest/api/category"
require "kounta/rest/api/product"

module Kounta
	module REST
		class Client
			include Kounta::REST::API::Category
			include Kounta::REST::API::Product

			def initialize
			end

		end
	end
end