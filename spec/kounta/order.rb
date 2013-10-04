require "helper"

describe Kounta::Order do

	subject { Kounta::Order.new }

	it "should be able composite payments" do
		subject.payments << Kounta::Payment.new(:amount => 50.00)
		subject.to_hash[:payments].length.should be(1)
		subject.to_hash[:payments][0][:amount].should be(50.00)
	end

	it "should be able composite lines" do
		subject.lines << Kounta::Line.new(:quantity => 4)
		subject.to_hash[:lines].length.should be(1)
		subject.to_hash[:lines][0][:quantity].should be(4)
	end

	it "should be able to resolve the create resource path" do
		subject.save!.should be_an_instance_of(Kounta::Order)
		WebMock.should have_requested(:post, group_endpoint('orders'))
	end

	it "should be able to resolve the update resource path" do
		subject.id = 2345
		subject.save!.should be_an_instance_of(Kounta::Order)
		WebMock.should have_requested(:put, singular_endpoint('orders'))
	end

end