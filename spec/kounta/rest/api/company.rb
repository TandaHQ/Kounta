require "helper"

describe Kounta::REST::API::Company do

	before do
		@client = Kounta::REST::Client.new
	end

	it "should return a company by id" do
		@client.company(1234).should be_a Kounta::Company
	end

	it "should return the authenticated company without an id" do
		@client.company.should be_a Kounta::Company
	end

end