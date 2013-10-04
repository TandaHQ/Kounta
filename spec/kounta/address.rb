require "helper"

describe Kounta::Address do

	subject { Kounta::Company.new.customer(701892).address(198109) }

	it "should have a resource path" do
		subject.resource_path.should eq({people: 701892, addresses: 198109})
	end

end