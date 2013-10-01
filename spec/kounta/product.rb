require "helper"

describe Kounta::Product do

	subject { Kounta::Company.new.site(985).product(3274192) }

	it "should have an id" do
		subject.id.should be(1)
	end

	it "should have a name" do
		subject.name.should eq("Salomon Undhof Wieden & Berg Gruner Veltliner")
	end

	it "should have a description" do
		subject.description.should eq("Pale-coloured, with a rich nose of fresh herbs and peppery cucumber varietal character. Soft, rounded and nicely balanced with a clean, dry palate and some opulence.")
	end

	it "should have an image" do
		subject.image.should eq("http://danmurphys.com.au/media/DM/Product/750x2000/332012_0_9999_v1_m56577569853958110.jpg")
	end

	it "should be able to to test for tags" do
		subject.tags_include?("Rosebud").should be(false)
		subject.tags_include?("Fragile").should be(true)
	end

	it "should be able to return which categories it belongs to" do
		subject.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

	it "should be able to save a product" do
		subject.save!.should be_an_instance_of(Kounta::Product)
		WebMock.should have_requested(:put, singular_endpoint('products'))
	end

	it "should be able to create a product" do
		product = Kounta::Product.new({"company_id" => 1234, "name" => "New Product", "description" => "All about my new product", "tags" => ['Website', 'New']})
		product.save!.should be_an_instance_of(Kounta::Product)
		WebMock.should have_requested(:post, group_endpoint('products'))
	end

end