require "helper"

describe Kounta::Site do

	before do
		@client = Kounta::REST::Client.new
		@site = @client.company.site(985)
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

end