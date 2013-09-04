require "helper"

describe Kounta::REST::API::Category do

	before do
		@client = Kounta::REST::Client.new
	end

	it "should return categories for a company" do
		@client.company_categories(1234).each { |category|
			category.should be_a Kounta::Category
		}
	end

	it "should fetch a category by id" do
		@client.company_category(1234, 567).should be_a Kounta::Category
	end

	it "should fetch categories a product belongs to" do
		@client.company_product_categories(1234, 984).each { |category|
			category.should be_a Kounta::Category
		}
	end

	it "should get categories for a site" do
		@client.company_site_category(1234, 34, 567).should be_a Kounta::Category
	end

end