require "helper"

describe Kounta::Product do

	before do
		@product = Kounta::Company.new.site(985).product(3274192)
	end

	it "should have an id" do
		@product.id.should be(1)
	end

	it "should have a name" do
		@product.name.should eq("Salomon Undhof Wieden & Berg Gruner Veltliner")
	end

	it "should have a description" do
		@product.description.should eq("Pale-coloured, with a rich nose of fresh herbs and peppery cucumber varietal character. Soft, rounded and nicely balanced with a clean, dry palate and some opulence.")
	end

	it "should be able to to test for tags" do
		@product.tags_include?("Fragile").should be(false)
		@product.tags_include?("Website").should be(true)
	end

	it "should be able to return which categories it belongs to" do
		@product.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

end