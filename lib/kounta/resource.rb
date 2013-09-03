require_relative "rest/client"

module Kounta

	class Resource

		def client
			@client ||= Kounta::REST::Client.new
		end

	end

end