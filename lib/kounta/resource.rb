require_relative "rest/client"

module Kounta

	class Resource

		def client
			@client ||= Kounta::REST::Client.new
		end

		def save!
			raise Errors::IncompleteAttributes if missing_required_attributes?
			@data = new? ? client.perform(resource_path, :post, to_hash) : client.perform(resource_path, :put, to_hash)
			self
		end

		private

		def new?
			!id
		end

	end

end