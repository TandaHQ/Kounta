require_relative "rest/client"

module Kounta

	class Resource

		def client
			@client ||= Kounta::REST::Client.new
		end

		def save!
			@data = new? ? client.perform(create_path, :post, to_hash) : client.perform(save_path, :put, to_hash)
			self
		end

		private

		def new?
			!id
		end

	end

end