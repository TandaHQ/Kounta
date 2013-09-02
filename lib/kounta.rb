require_relative "kounta/version"
require_relative "kounta/rest/client"

module Kounta
	def self.root
		File.expand_path '../..', __FILE__
	end
end