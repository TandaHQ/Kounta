module Kounta

	class Staff < Kounta::Resource
		property :company_id
		property :first_name
		property :last_name
		property :primary_email_address
		property :email_addresses
		property :phone
		property :mobile
		property :fax
		property :shipping_address
		property :postal_address
		property :addresses
		property :sites
		property :permissions
		property :image

		def name
			"#{first_name} #{last_name}"
		end

		has_many :shifts, Kounta::Shift, {:company_id => :company_id}, Proc.new { |klass, date| {companies: klass.company_id, staff: klass.id, shifts: Kounta.format_date(date)} }
		has_many :shifts_since, Kounta::Shift, {:company_id => :company_id}, Proc.new { |klass, date| {companies: klass.company_id, staff: klass.id, shifts: nil, since: Kounta.format_date(date)} }

		def resource_path
			{companies: company_id, staff: id}
		end

	end

end