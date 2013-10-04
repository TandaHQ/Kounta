require_relative "kounta/version"
require_relative "kounta/errors"
require_relative "kounta/rest/client"
require_relative "kounta/resource"
require_relative "kounta/category"
require_relative "kounta/tax"
require_relative "kounta/product"
require_relative "kounta/address"
require_relative "kounta/payment"
require_relative "kounta/line"
require_relative "kounta/order"
require_relative "kounta/customer"
require_relative "kounta/site"
require_relative "kounta/price_list"
require_relative "kounta/company"

module Kounta
	def self.root
		File.expand_path '../..', __FILE__
	end
end