require 'helper'

describe Kounta::Address do
  subject { Kounta::Company.new(@client).customer(701_892).address(198_109) }

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(people: 701_892, addresses: 198_109)
  end
end
