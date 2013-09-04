require "helper"

describe Kounta::Company do

	before do
		@company = Kounta::Company.new
	end

	it "should have an id" do
		@company.id.should be(2345)
	end

	it "should convert to a hash" do
		@company.to_h.should be_an_instance_of(Hash)
	end

	it "should have a single category" do
		@company.category(8263).should be_an_instance_of(Kounta::Category)
	end

	it "should have categories" do
		@company.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

	it "should have sites" do
		@company.sites.each {|site| site.should be_an_instance_of(Kounta::Site) }
	end

	it "should have a single site" do
		@company.site(985).should be_an_instance_of(Kounta::Site)
	end

	it "should have price lists" do
		@company.price_lists.each {|price_list| price_list.should be_an_instance_of(Kounta::PriceList) }
	end

	it "should have a price list" do
		@company.price_list(236).should be_an_instance_of(Kounta::PriceList)
	end

	it "should have a base price list" do
		@company.base_price_list.should be_an_instance_of(Kounta::PriceList)
	end

end