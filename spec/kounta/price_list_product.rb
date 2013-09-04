require "helper"

describe Kounta::PriceList do

	before do
		@price_list_product = Kounta::Company.new.price_list(236).price_list_products.first
	end

	it "should have an id" do
		@price_list_product.id.should be(5510)
	end

	it "should have a name" do
		@price_list_product.name.should eq("Cappuccino")
	end

	it "should have a unit price" do
		@price_list_product.unit_price.should be(1.25)
	end

end