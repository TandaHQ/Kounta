module Kounta
	module Errors
		class KountaError < StandardError; end
		class MissingOauthDetails < KountaError; end
		class UnknownResourceAttribute < KountaError; end
		class APIError < KountaError; end
		class RequestError < KountaError; end
	end
end