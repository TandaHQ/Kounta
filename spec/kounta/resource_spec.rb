require 'helper'

describe Kounta::Resource do
  subject { Kounta::Resource }

  before :each do
    subject.has_one(:address, Kounta::Address, { company_id: :id }, proc { |klass, item_id| { companies: klass.id, addresses: item_id } })
    subject.has_many(:addresses, Kounta::Address, { company_id: :id }, proc { |klass| { companies: klass.id, addresses: nil } })
    @instance = subject.new(id: 345)
    @instance.client = @client
  end

  it 'should populate details if created with a hash' do
    expect(@instance.id).to be(345)
  end

  it 'should coerce an array of data to itself' do
    results = subject.coerce [{ id: 1 }, { id: 2 }, { id: 3 }]
    results.each do |result|
      expect(result).to be_an_instance_of subject
    end
  end

  it 'should create a has_one relationship mapping' do
    expect(@instance).to respond_to(:address)
  end

  it 'should respond with an object when supplied with an id' do
    expect(@instance.address(1)).to be_an_instance_of Kounta::Address
    expect(WebMock).to have_requested(:get, singular_endpoint('addresses'))
  end

  it 'should be able to create an empty instance of the has_one relationship and apply mappings to it' do
    @instance.id = 162
    address = @instance.address
    expect(address).to be_an_instance_of Kounta::Address
    expect(address.company_id).to be(162)
  end

  it 'should create a has_many relationship mapping' do
    expect(@instance).to respond_to(:addresses)
  end

  it 'should respond with an array of objects' do
    @instance.addresses.each do |address|
      expect(address).to be_an_instance_of Kounta::Address
    end
  end

  it 'should apply assignments to the has_many relationship' do
    @instance.addresses.each do |address|
      expect(address.company_id).to be(@instance.id)
    end
  end

  it 'should have a reference to the rest client' do
    expect(@instance.client).to be_an_instance_of Kounta::REST::Client
  end

  it 'should be able to serialise itself to a hash' do
    expect(@instance.to_hash.class).to be(Hash)
    expect(@instance.to_hash(merge: 'me')).to eq(merge: 'me')
  end

  it 'should not raise an error when presented with an unknown attribute' do
    instance = subject.new(id: 345, new_attribute: 'value')
    expect(instance.to_hash).to eq({})
  end

  it 'should be able to save a new object' do
    subject.property :number
    subject.property :product_id
    subject.property :quantity
    subject.property :notes
    subject.property :price_variation
    instance = subject.new
    instance.client = @client
    instance.id = nil
    instance.define_singleton_method(:resource_path, proc { { companies: 162, orders: 6789, lines: nil } })
    expect(instance.save!).to be_an_instance_of subject
    expect(WebMock).to have_requested(:post, group_endpoint('lines'))
  end

  it 'should be able to update an existing object' do
    subject.property :number
    subject.property :product_id
    subject.property :quantity
    subject.property :notes
    subject.property :price_variation
    instance = subject.new
    instance.client = @client
    instance.id = 162
    instance.define_singleton_method(:resource_path, proc { { companies: 162, orders: 6789, lines: 2345 } })
    expect(instance.save!).to be_an_instance_of subject
    expect(WebMock).to have_requested(:put, singular_endpoint('lines'))
  end
end
