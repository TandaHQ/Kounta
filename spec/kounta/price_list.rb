require "helper"

describe Kounta::PriceList do

	before do
		@price_list = Kounta::Company.new.price_list(236)
	end

	it "should have an id" do
		@price_list.id.should be(236)
	end

	it "should have a name" do
		@price_list.name.should eq("VIP Prices")
	end

	it "should have price list products" do
		@price_list.price_list_products.each {|price_list_product| price_list_product.should be_an_instance_of(Kounta::PriceListProduct) }
	end

end