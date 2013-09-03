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

end