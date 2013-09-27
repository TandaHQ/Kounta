module Kounta
	module Errors

		class KountaError < StandardError; end

		class IncompleteAttributes < KountaError; end

	end
end