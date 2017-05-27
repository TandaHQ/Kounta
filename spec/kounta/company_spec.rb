require 'helper'
require 'oj'

describe Kounta::Company do
  subject { Kounta::Company }

  it 'should be able to create a company from an existing hash' do
    subject.new(@client, Oj.load(File.read("#{Kounta.root}/spec/fixtures/companies_me.json")))
  end

  it 'should be able to create a company without a hash' do
    expect(subject.new(@client)).to be_an_instance_of subject
  end

  it 'should have a resource path' do
    expect(subject.new(@client).resource_path).to eq(companies: 162)
  end

  it 'should have a base price list' do
    expect(subject.new(@client).base_price_list).to be_an_instance_of Kounta::PriceList
  end
end
