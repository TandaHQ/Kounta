module Kounta
	module Errors
		class KountaError < StandardError; end
		class MissingOauthDetails < KountaError; end
		class UnknownResourceAttribute < KountaError; end
	end
end