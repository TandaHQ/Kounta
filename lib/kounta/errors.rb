module Kounta
	module Errors
		class KountaError < StandardError; end
		class MissingOauthDetails < KountaError; end
		class APIError < KountaError; end
	end
end