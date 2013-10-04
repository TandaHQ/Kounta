require "helper"

describe Kounta::Site do

	subject { Kounta::Company.new.site(985) }

	it "should have a resource path" do
		subject.resource_path.should eq({companies: 2345, sites: 985})
	end

end