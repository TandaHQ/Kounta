require "helper"

describe Kounta::Site do

	subject { Kounta::Company.new.site(985) }

	it "should have an id" do
		subject.id.should be(985)
	end

	it "should have a name" do
		subject.name.should eq("Online Store")
	end

	it "should have a code" do
		subject.code.should eq("Online")
	end

	it "should have products" do
		subject.products.each {|product| product.should be_an_instance_of(Kounta::Product) }
	end

	it "should have a product" do
		subject.product(3274192).should be_an_instance_of(Kounta::Product)
	end

	it "should have categories" do
		subject.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

	it "should have a category" do
		subject.category(8263).should be_an_instance_of(Kounta::Category)
	end

	it "should have addresses" do
		subject.addresses.each {|address| address.should be_an_instance_of(Kounta::Address) }
	end

	it "should have an address" do
		subject.address(8263).should be_an_instance_of(Kounta::Address)
	end

end