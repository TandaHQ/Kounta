require "helper"

describe Kounta::Category do

	subject { Kounta::Company.new.category(1) }

	it "should have a resource path" do
		subject.resource_path.should eq({companies: 162, categories: 1})
	end

end