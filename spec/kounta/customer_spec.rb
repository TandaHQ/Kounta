require 'helper'

describe Kounta::Customer do
  subject { Kounta::Company.new(@client).customer(389_427) }

  it 'should have a name' do
    expect(subject.name).to eq('Samuel Richardson')
  end

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(companies: 162, customers: 389_427)
  end
end
