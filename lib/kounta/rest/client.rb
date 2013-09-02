require "kounta/rest/api/category"

module Kounta
	module REST
		class Client
			include Kounta::REST::API::Category

			def initialize
				puts "=== found init"
			end

		end
	end
end