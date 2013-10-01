require_relative "resource"

module Kounta

	class Tax < Kounta::Resource
		property :company_id, :required => true
		property :code
		property :name
		property :rate
	end

end