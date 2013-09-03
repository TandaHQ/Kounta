require "helper"

describe Kounta::Company do

	before do
		@company = Kounta::Company.new
	end

	it "should have an id" do
		@company.id.should be(2345)
	end

	it "should have categories" do
		@company.categories.length.should be(2)
		@company.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

	it "should have a single category" do
		@company.category(8263).should be_an_instance_of(Kounta::Category)
	end

	it "should have sites" do
		@company.sites.length.should be(2)
		@company.sites.each {|site| site.should be_an_instance_of(Kounta::Site) }
	end

	it "should have a single site" do
		@company.site(985).should be_an_instance_of(Kounta::Site)
	end

end