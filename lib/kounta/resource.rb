require 'hashie'
require_relative "rest/client"

module Kounta

	class Resource < Hashie::Dash
		include Hashie::Extensions::Coercion

		property :id
		property :created_at
		property :updated_at

		def self.coerce(data)
			if data.kind_of? Array
				data.map { |item| self.new(item) }
			else
				self.new(data)
			end
		end

		def self.has_one(sym, klass, assignments, route)
			define_method(sym) do |item_id=nil|
				if item_id
					client.object_from_response(klass, :get, route.call(self, item_id))
				else
					instance = klass.new
					assignments.each_pair do |k,v|
						instance[k] = self[v]
					end
					instance
				end
			end
		end

		def self.has_many(sym, klass, route)
			define_method(sym) do
				client.objects_from_response(klass, :get, route.call(self))
			end
		end

		def initialize(hash={})
			if hash
				hash.each_pair do |k,v|
					self[k] = v
				end
			end
		end

		def client
			@client ||= Kounta::REST::Client.new
		end

		def to_hash(hash={})
			{}.tap do |returning|
				self.class.properties.each do |property|
					next if ignored_properties.include?(property)
					returning[property] = self[property]
				end
			end.merge(hash)
		end

		def save!
			response = new? ? client.perform(resource_path, :post, to_hash) : client.perform(resource_path, :put, to_hash)
			response.each_pair do |k,v|
				self[k] = v
			end
			self
		end

		def new?
			!id
		end

		def ignored_properties(array=[])
			array + [:created_at, :updated_at]
		end

	end

end