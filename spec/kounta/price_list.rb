require "helper"

describe Kounta::PriceList do

	subject { Kounta::Company.new.price_list(236) }

	it "should have an id" do
		subject.id.should be(236)
	end

	it "should have a name" do
		subject.name.should eq("VIP Prices")
	end

	it "should have price list products" do
		subject.products.each {|product| product.should be_an_instance_of(Kounta::Product) }
	end

end