require "helper"

describe Kounta::Customer do

	before do
		@customer = Kounta::Company.new.customer(8263)
	end

	it "should have an id" do
		@customer.id.should be(389427)
	end

	it "should have a first name" do
		@customer.first_name.should eq("Samuel")
	end

	it "should have a last name" do
		@customer.last_name.should eq("Richardson")
	end

	it "should have a name" do
		@customer.name.should eq("Samuel Richardson")
	end

	it "should have an email" do
		@customer.email.should eq("sam@richardson.co.nz")
	end

	it "should be able to save a customer" do
		@customer.save!.should be_an_instance_of(Kounta::Customer)
		WebMock.should have_requested(:put, singular_endpoint('customers'))
	end

	it "should be able to create a customer" do
		customer = Kounta::Customer.new({"company_id" => 1234, "first_name" => "Sam", "last_name" => "Richardson", "email" => "sam@richardson.co.nz"})
		customer.save!.should be_an_instance_of(Kounta::Customer)
		WebMock.should have_requested(:post, group_endpoint('customers'))
	end

	it "should raise an error when saving without the required attributes" do
		customer = Kounta::Customer.new({"first_name" => "Sam", "last_name" => "Richardson", "email" => "sam@richardson.co.nz"})
		expect { customer.save! }.to raise_error Kounta::Errors::IncompleteAttributes
	end

end