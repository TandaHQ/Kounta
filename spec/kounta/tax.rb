require "helper"

describe Kounta::PriceList do

	subject { Kounta::Company.new.taxes.first }

	it "should have an id" do
		subject.id.should be(829)
	end

	it "should have a code" do
		subject.code.should eq("GST")
	end

	it "should have a name" do
		subject.name.should eq("Goods & Services Tax")
	end

	it "should have a rate" do
		subject.rate.should eq(0.1)
	end

end