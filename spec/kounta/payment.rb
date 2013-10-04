require "helper"

describe Kounta::Payment do

	subject { Kounta::Payment.new }

	it "should have a resource path" do
		subject.company_id = 2345
		subject.order_id = 6789
		subject.id = 1
		subject.resource_path.should eq({companies: 2345, orders: 6789, payments: 1})
	end

end