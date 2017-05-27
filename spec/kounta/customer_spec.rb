require 'helper'

describe Kounta::Customer do
  subject { Kounta::Company.new.customer(389_427) }

  it 'should have a name' do
    subject.name.should eq('Samuel Richardson')
  end

  it 'should have a resource path' do
    subject.resource_path.should eq(companies: 162, customers: 389_427)
  end
end
