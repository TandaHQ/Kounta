require_relative "resource"

module Kounta

	class PriceListProduct < Kounta::Resource

		def initialize(data=nil)
			@data = data
		end

		def product_id
			@data[:id].to_i
		end

		def name
			@data[:name]
		end

		def unit_price
			@data[:unit_price].to_f
		end

	end

end