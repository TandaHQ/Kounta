require "helper"

describe Kounta::PriceListProduct do

	before do
		@price_list_product = Kounta::Company.new.price_list(236).price_list_products.first
	end

	it "should have a product id" do
		@price_list_product.product_id.should be(1)
	end

	it "should have a name" do
		@price_list_product.name.should eq("Test")
	end

	it "should have a unit price" do
		@price_list_product.unit_price.should be(10.25)
	end

end