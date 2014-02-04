require 'hashie'
require_relative "rest/client"

module Kounta

	class Resource < Hashie::Dash
		include Hashie::Extensions::Coercion

		attr_accessor :client

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
			define_method(sym) do |item_id=nil, *args|
				if item_id
					assign_into(client.object_from_response(klass, :get, route.call(self, item_id), {:params => args[0]}), self, assignments)
				else
					assign_into(klass.new, self, assignments)
				end
			end
		end

		def self.has_many(sym, klass, assignments, route)
			define_method(sym) do |has_many_params = nil, *args|
				client.objects_from_response(klass, :get, route.call(self, has_many_params), {:params => args[0]}).map {|returned_klass| assign_into(returned_klass, self, assignments) }
			end
		end

		def initialize(hash={})
			if hash
				hash.each_pair do |k,v|
					begin
						self[k] = v if self.respond_to? k.to_sym
					rescue NoMethodError => e
						raise Kounta::Errors::UnknownResourceAttribute.new("Unknown attribute: #{k} on resource #{self.class}")
					end
				end
			end
		end

		def to_hash(hash={})
			{}.tap do |returning|
				self.class.properties.each do |property|
					next if ignored_properties.include?(property)
					returning[property] = self[property] if self[property]
				end
			end.merge(hash)
		end

		def save!
			response = new? ? client.perform(resource_path, :post, {:body => to_hash}) : client.perform(resource_path, :put, {:body => to_hash})

			# automatically follow redirects to resources
			if response.status == 201
				response = client.perform(response.headers["location"], :get)
			end

			response.parsed.each_pair do |k,v|
				self[k] = v if self.respond_to? k.to_sym
			end

			self
		end

		def new?
			!id
		end

		def ignored_properties(array=[])
			array + [:created_at, :updated_at, :id, :company_id]
		end

		private

			def assign_into(klass, assigner, assignments)
				klass.client = assigner.client
				assignments.each_pair do |k,v|
					klass[k] = assigner[v]
				end
				klass
			end

	end

end