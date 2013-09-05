require "helper"

describe Kounta::Category do

	before do
		@category = Kounta::Company.new.category(8263)
	end

	it "should have an id" do
		@category.id.should be(1)
	end

	it "should have a name" do
		@category.name.should eq("France")
	end

	it "should have a description" do
		@category.description.should eq("Wine from the country of France")
	end

end