require "helper"
require 'oj'

describe Kounta::Company do

	subject { Kounta::Company.new }

	it "should be able to create a company" do
		Kounta::Company.new(Oj.load(File.read("#{Kounta.root}/spec/fixtures/companies_me.json")))
	end

	it "should have an id" do
		subject.id.should be(2345)
	end

	it "should have a customer" do
		subject.customer(389427).should be_an_instance_of(Kounta::Customer)
	end

	it "should have customers" do
		subject.customers.each {|customer| customer.should be_an_instance_of(Kounta::Customer) }
	end

	it "should have a category" do
		subject.category(8263).should be_an_instance_of(Kounta::Category)
	end

	it "should have categories" do
		subject.categories.each {|category| category.should be_an_instance_of(Kounta::Category) }
	end

	it "should have a product" do
		subject.product(3274192).should be_an_instance_of(Kounta::Product)
	end

	it "should have products" do
		subject.products.each {|product| product.should be_an_instance_of(Kounta::Product) }
	end

	it "should have sites" do
		subject.sites.each {|site| site.should be_an_instance_of(Kounta::Site) }
	end

	it "should have a site" do
		subject.site(985).should be_an_instance_of(Kounta::Site)
	end

	it "should have price lists" do
		subject.price_lists.each {|price_list| price_list.should be_an_instance_of(Kounta::PriceList) }
	end

	it "should have a price list" do
		subject.price_list(236).should be_an_instance_of(Kounta::PriceList)
	end

	it "should have a base price list" do
		subject.base_price_list.should be_an_instance_of(Kounta::PriceList)
	end

	it "should have taxes" do
		subject.taxes.each {|tax| tax.should be_an_instance_of(Kounta::Tax) }
	end

end