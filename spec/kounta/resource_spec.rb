require "helper"

describe Kounta::Resource do

	subject { Kounta::Resource }

	before :each do
		subject.has_one(:address, Kounta::Address, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, addresses: item_id} })
		subject.has_many :addresses, Kounta::Address, lambda { |klass| {companies: klass.id, addresses: nil} }
		@instance = subject.new({:id => 345})
	end

	it "should populate details if created with a hash" do
		@instance.id.should be(345)
	end

	it "should coerce an array of data to itself" do
		results = subject.coerce [{:id => 1}, {:id => 2}, {:id => 3}]
		results.each do |result|
			result.should be_an_instance_of subject
		end
	end

	it "should create a has_one relationship mapping" do
		@instance.should respond_to(:address)
	end

	it "should respond with an object when supplied with an id" do
		@instance.address(1).should be_an_instance_of Kounta::Address
		WebMock.should have_requested(:get, singular_endpoint('addresses'))
	end

	it "should be able to create an empty instance of the relationship and apply mappings to it" do
		@instance.id = 2345
		address = @instance.address
		address.should be_an_instance_of Kounta::Address
		address.company_id.should be(2345)
	end

	it "should create a has_many relationship mapping" do
		@instance.should respond_to(:addresses)
	end

	it "should respond with an array of objects" do
		@instance.addresses.each do |address|
			address.should be_an_instance_of Kounta::Address
		end
	end

	it "should have a reference to the rest client" do
		@instance.client.should be_an_instance_of Kounta::REST::Client
	end

	it "should be able to serialise itself to a hash" do
		@instance.to_hash.should eq({:id => 345})
		@instance.to_hash({:merge => "me"}).should eq({:id => 345, :merge => "me"})
	end

	it "should be able to save a new object" do
		subject.property :number
		subject.property :product_id
		subject.property :quantity
		subject.property :notes
		subject.property :price_variation
		instance = subject.new
		instance.id = nil
		instance.define_singleton_method :resource_path, lambda { {companies: 2345, orders: 6789, lines: nil} }
		instance.save!.should be_an_instance_of subject
		WebMock.should have_requested(:post, group_endpoint('lines'))
	end

	it "should be able to update an existing object" do
		subject.property :number
		subject.property :product_id
		subject.property :quantity
		subject.property :notes
		subject.property :price_variation
		instance = subject.new
		instance.id = 2345
		instance.define_singleton_method :resource_path, lambda { {companies: 2345, orders: 6789, lines: 2345} }
		instance.save!.should be_an_instance_of subject
		WebMock.should have_requested(:put, singular_endpoint('lines'))
	end

end