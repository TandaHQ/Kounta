require "helper"

describe Kounta::Category do

	before do
		@category = Kounta::Company.new.category(8263)
	end

	it "should have an id" do
		@category.id.should be(8263)
	end

	it "should have a name" do
		@category.name.should eq("Fruit & Vegetables")
	end

	it "should have a description" do
		@category.description.should eq("Fresh fruit and veg from local and imported sources")
	end

end