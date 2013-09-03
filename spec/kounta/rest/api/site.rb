require "helper"

describe Kounta::REST::API::Site do

	before do
		@client = Kounta::REST::Client.new
	end

	it "should return sites for a company" do
		@client.company_sites(1234).each { |site|
			site.should be_a Kounta::Site
		}
	end

	it "should fetch a site by id" do
		@client.company_site(1234, 567).should be_a Kounta::Site
	end

end