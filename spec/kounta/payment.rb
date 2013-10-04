require "helper"

describe Kounta::Payment do

	before :each do
		@subject = Kounta::Payment.new
		@subject.company_id = 2345
		@subject.order_id = 1111
		@subject.method_id = 3
		@subject.amount = 56.60
		@subject.ref = "INV2-8M9F-B8UN-YQ5S-2G7K"
	end

	it "should be able to save and update payments" do
		subject.save!.should be_an_instance_of(Kounta::Payment)
		WebMock.should have_requested(:post, group_endpoint('payments'))
		subject.save!
		WebMock.should have_requested(:put, singular_endpoint('payments'))
	end

end