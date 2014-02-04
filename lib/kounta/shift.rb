module Kounta

	class Shift < Kounta::Resource
		property :company_id
		property :staff_member
		property :site
		property :started_at
		property :finished_at
		property :breaks

		#coerce_key :staff_member, Kounta::Staff
		#coerce_key :site, Kounta::Site
		coerce_key :breaks, Kounta::Break

		def initialize(hash={})
			super(hash)
			self.breaks ||= []
		end

		def to_hash
			returning = {}
			returning[:breaks] = breaks.map {|b| b.to_hash } if breaks && breaks.length > 0
			super(returning)
		end
	end

end

