require 'helper'

describe Kounta::Order do
  subject { Kounta::Company.new.customer(701_892).order(93_824_701) }

  it 'should be able to add payments to new orders' do
    new_order = Kounta::Order.new
    new_order.payments << Kounta::Payment.new(amount: 50.00)
    new_order.to_hash[:payments].length.should be(1)
    new_order.to_hash[:payments][0][:amount].should eq(50.00)
  end

  it 'should be able to add lines to new orders' do
    new_order = Kounta::Order.new
    new_order.lines << Kounta::Line.new(quantity: 4)
    new_order.to_hash[:lines].length.should be(1)
    new_order.to_hash[:lines][0][:quantity].should be(4)
  end

  it 'should be able to add and serialise payments to created orders' do
    subject.payments << Kounta::Payment.new(amount: 50.00)
    subject.to_hash[:payments].length.should be(3)
    subject.to_hash[:payments][2][:amount].should eq(50.00)
  end

  it 'should be able to add and serialise lines to created orders' do
    subject.lines << Kounta::Line.new(quantity: 4)
    subject.to_hash[:lines].length.should be(3)
    subject.to_hash[:lines][0][:quantity].should be(6)
  end

  it 'should have a resource path' do
    subject.resource_path.should eq(companies: 162, orders: 93_824_701)
  end
end
