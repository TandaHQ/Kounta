require "helper"

describe Kounta::Order do

	subject { Kounta::Order.new }

	it "should be able to add and serialise payments" do
		subject.payments << Kounta::Payment.new(:amount => 50.00)
		subject.to_hash[:payments].length.should be(1)
		subject.to_hash[:payments][0][:amount].should be(50.00)
	end

	it "should be able to add and serialise lines" do
		subject.lines << Kounta::Line.new(:quantity => 4)
		subject.to_hash[:lines].length.should be(1)
		subject.to_hash[:lines][0][:quantity].should be(4)
	end

	it "should have a resource path" do
		subject.company_id = 2345
		subject.id = 1
		subject.resource_path.should eq({companies: 2345, orders: 1})
	end

end