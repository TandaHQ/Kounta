require "helper"

describe Kounta::Line do

	subject { Kounta::Line.new }

	it "should be able to resolve the create resource path" do
		subject.save!.should be_an_instance_of(Kounta::Line)
		WebMock.should have_requested(:post, group_endpoint('lines'))
	end

	it "should be able to resolve the update resource path" do
		subject.id = 2345
		subject.save!.should be_an_instance_of(Kounta::Line)
		WebMock.should have_requested(:put, singular_endpoint('lines'))
	end

end