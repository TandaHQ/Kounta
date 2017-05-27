require 'helper'

describe Kounta::Address do
  subject { Kounta::Company.new(Kounta::REST::Client.new).customer(701_892).address(198_109) }

  it 'should have a resource path' do
    subject.resource_path.should eq(people: 701_892, addresses: 198_109)
  end
end
