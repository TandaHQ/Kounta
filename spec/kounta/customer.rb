require "helper"

describe Kounta::Customer do

	subject { Kounta::Company.new.customer(8263) }

	it "should have an id" do
		subject.id.should be(389427)
	end

	it "should have a first name" do
		subject.first_name.should eq("Samuel")
	end

	it "should have a last name" do
		subject.last_name.should eq("Richardson")
	end

	it "should have a name" do
		subject.name.should eq("Samuel Richardson")
	end

	it "should have an email" do
		subject.primary_email_address.should eq("sam@richardson.co.nz")
	end

	it "should have addresses" do
		subject.addresses.each {|address| address.should be_an_instance_of(Kounta::Address) }
	end

	it "should have an address" do
		subject.address(8263).should be_an_instance_of(Kounta::Address)
	end

	it "should be able to save a customer" do
		subject.save!.should be_an_instance_of(Kounta::Customer)
		WebMock.should have_requested(:put, singular_endpoint('customers'))
	end

	it "should be able to create a customer" do
		customer = Kounta::Customer.new({"company_id" => 1234, "first_name" => "Sam", "last_name" => "Richardson", "primary_email_address" => "sam@richardson.co.nz"})
		customer.save!.should be_an_instance_of(Kounta::Customer)
		WebMock.should have_requested(:post, group_endpoint('customers'))
	end

	it "should have orders" do
		subject.orders.each {|order| order.should be_an_instance_of(Kounta::Order) }
	end

end