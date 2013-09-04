require "helper"

describe Kounta::Site do

	before do
		@product = Kounta::Company.new.site(985).product(3274192)
	end

	it "should have an id" do
		@product.id.should be(3274192)
	end

	it "should have a name" do
		@product.name.should eq("Strawberry Jam")
	end

	it "should have a code" do
		@product.code.should eq("jam839")
	end

	it "should have a description" do
		@product.description.should eq("Delicious, sugary goodness in a jar.")
	end

	it "should be able to to test for a tag" do
		@product.tags_include?("Fragile").should be(true)
	end

	it "should be able to return which categories it belongs to" do
		@product.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

end