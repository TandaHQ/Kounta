module Kounta

	class Register < Kounta::Resource
		property :company_id
		property :code
		property :name
		property :site_id

		def resource_path
			{companies: company_id, registers: id}
		end

	end

end