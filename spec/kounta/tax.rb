require "helper"

describe Kounta::PriceList do

	before do
		@tax = Kounta::Company.new.taxes.first
	end

	it "should have an id" do
		@tax.id.should be(829)
	end

	it "should have a code" do
		@tax.code.should eq("GST")
	end

	it "should have a name" do
		@tax.name.should eq("Goods & Services Tax")
	end

	it "should have a rate" do
		@tax.rate.should eq(0.1)
	end

end