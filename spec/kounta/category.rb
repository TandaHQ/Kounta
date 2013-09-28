require "helper"

describe Kounta::Category do

	before do
		@category = Kounta::Company.new.category(8263)
	end

	it "should have an id" do
		@category.id.should be(1)
	end

	it "should have a name" do
		@category.name.should eq("France")
	end

	it "should have a description" do
		@category.description.should eq("Wine from the country of France")
	end

	it "should be able to save a category" do
		@category.save!.should be_an_instance_of(Kounta::Category)
		WebMock.should have_requested(:put, singular_endpoint('categories'))
	end

	it "should be able to create a category" do
		category = Kounta::Category.new({"company_id" => 1234, "name" => "New category", "description" => "All about my new category"})
		category.save!.should be_an_instance_of(Kounta::Category)
		WebMock.should have_requested(:post, group_endpoint('categories'))
	end

	it "should raise an error when saving without the required attributes" do
		category = Kounta::Category.new({"name" => "New category", "description" => "All about my new category"})
		expect { category.save! }.to raise_error Kounta::Errors::IncompleteAttributes
	end

end