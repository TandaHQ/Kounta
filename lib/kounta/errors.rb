module Kounta
	module Errors
		class KountaError < StandardError; end
		class MissingOauthDetails < KountaError; end
	end
end