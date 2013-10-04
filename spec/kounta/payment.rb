require "helper"

describe Kounta::Payment do

	subject { Kounta::Payment.new }

	it "should be able to resolve the create resource path" do
		subject.save!.should be_an_instance_of(Kounta::Payment)
		WebMock.should have_requested(:post, group_endpoint('payments'))
	end

	it "should be able to resolve the update resource path" do
		subject.id = 2345
		subject.save!.should be_an_instance_of(Kounta::Payment)
		WebMock.should have_requested(:put, singular_endpoint('payments'))
	end

end