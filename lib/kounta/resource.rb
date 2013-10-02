require 'hashie'
require_relative "rest/client"

module Kounta

	class Resource < Hashie::Dash
		include Hashie::Extensions::Coercion

		property :id
		property :created_at
		property :updated_at

		def self.coerce(items)
			items.map do |item|
				self.new(item)
			end
		end

		def self.has_one(sym, klass, assignments, route)
			define_method(sym) do |item_id|
				if item_id
					client.object_from_response(klass, :get, route.call(self, item_id))
				else
					product = klass.new
					assignments.each_pair do |k,v|
						product[k] = self[v]
					end
					product
				end
			end
		end

		def self.has_many(sym, klass, route)
			define_method(sym) do
				client.objects_from_response(klass, :get, route.call(self))
			end
		end

		def initialize(hash={})
			hash.each_pair do |k,v|
				self[k] = v
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