require 'helper'

describe Kounta::Person do
  subject { Kounta::Company.new(@client).person(701_892) }

  it 'should have a name' do
    expect(subject.name).to eq('Jamie McDonald')
  end

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(companies: 162, people: 701_892)
  end
end
