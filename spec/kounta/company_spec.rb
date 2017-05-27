require 'helper'
require 'oj'

describe Kounta::Company do
  subject { Kounta::Company }

  it 'should be able to create a company from an existing hash' do
    subject.new(Oj.load(File.read("#{Kounta.root}/spec/fixtures/companies_me.json")))
  end

  it 'should be able to create a company without a hash' do
    subject.new.should be_an_instance_of subject
  end

  it 'should have a resource path' do
    subject.new.resource_path.should eq(companies: 162)
  end

  it 'should have a base price list' do
    subject.new.base_price_list.should be_an_instance_of Kounta::PriceList
  end
end
