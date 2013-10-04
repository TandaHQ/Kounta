require "helper"

describe Kounta::Product do

	subject { Kounta::Company.new.site(985).product(1) }

	it "should be able to to test for tags" do
		subject.tags_include?("Rosebud").should be(false)
		subject.tags_include?("Fragile").should be(true)
	end

	it "should have a resource path" do
		subject.resource_path.should eq({companies: 2345, products: 1})
	end

end