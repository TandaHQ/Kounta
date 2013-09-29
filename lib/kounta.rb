require_relative "kounta/version"
require_relative "kounta/errors"
require_relative "kounta/rest/client"
require_relative "kounta/company"
require_relative "kounta/customer"
require_relative "kounta/address"
require_relative "kounta/category"
require_relative "kounta/site"
require_relative "kounta/price_list"
require_relative "kounta/product"

module Kounta
	def self.root
		File.expand_path '../..', __FILE__
	end
end