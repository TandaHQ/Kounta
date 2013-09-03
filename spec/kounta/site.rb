require "helper"

describe Kounta::Site do

	before do
		@site = Kounta::Company.new.site(985)
	end

	it "should have an id" do
		@site.id.should be(985)
	end

	it "should have a name" do
		@site.name.should eq("Downtown")
	end

	it "should have a code" do
		@site.code.should eq("DT")
	end

	it "should have products" do
		@site.products.length.should be(2)
		@site.products.each {|product| product.should be_an_instance_of(Kounta::Product) }
	end

	it "should have a product" do
		@site.product(985).should be_an_instance_of(Kounta::Product)
	end

	it "should have categories" do
		@site.categories.length.should be(2)
		@site.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

end