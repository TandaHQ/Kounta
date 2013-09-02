require "kounta/rest/client"
require "kounta/version"

module Kounta
	def self.root
		File.expand_path '../..', __FILE__
	end
end