require "helper"

describe Kounta::Category do

	before do
		@client = Kounta::REST::Client.new
		@category = @client.company.category(8263)
	end

	it "should have an id" do
		@category.id.should be(8263)
	end

	it "should have a name" do
		@category.name.should eq("Fruit & Vegetables")
	end

end