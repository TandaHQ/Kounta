require 'hashie'
require_relative "rest/client"

module Kounta

	class Resource < Hashie::Dash
		include Hashie::Extensions::Coercion

		property :id
		property :created_at
		property :updated_at

		def initialize(hash={})
			hash.each_pair do |k,v|
				self[k] = v
			end
		end

		def self.coerce(items)
			items.map do |item|
				self.new(item)
			end
		end

		def client
			@client ||= Kounta::REST::Client.new
		end

		def save!
			response = new? ? client.perform(resource_path, :post, to_hash) : client.perform(resource_path, :put, to_hash)
			response.each_pair do |k,v|
				self[k] = v
			end
			self
		end

		private

		def new?
			!id
		end

	end

end