require "helper"

describe Kounta::Address do

	subject { Kounta::Company.new.customer(8263).address(198109) }

	it "should have an id" do
		subject.id.should be(198109)
	end

	it "should have lines" do
		subject.lines.should eq(["Suite 5, Level 12", "44 Mutton Street"])
	end

	it "should have a city" do
		subject.city.should eq("Beeftown")
	end

	it "should have a zone" do
		subject.zone.should eq("NSW")
	end

	it "should have a postal code" do
		subject.postal_code.should eq("2112")
	end

	it "should have a country" do
		subject.country.should eq("AU")
	end

	it "should be able to save an address" do
		subject.save!.should be_an_instance_of(Kounta::Address)
		WebMock.should have_requested(:put, singular_endpoint('addresses'))
	end

	it "should be able to create an address" do
		customer = Kounta::Address.new({"people_id" => 4567, "lines" => ["Suite 5, Level 12", "44 Mutton Street"], "city" => "Melbourne", "zone" => "Victoria", "postal_code" => "3057", "country" => "Australia"})
		customer.save!.should be_an_instance_of(Kounta::Address)
		WebMock.should have_requested(:post, group_endpoint('addresses'))
	end

end