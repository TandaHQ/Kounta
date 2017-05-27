require 'helper'

describe Kounta::Person do
  subject { Kounta::Company.new.person(701_892) }

  it 'should have a name' do
    subject.name.should eq('Jamie McDonald')
  end

  it 'should have a resource path' do
    subject.resource_path.should eq(companies: 162, people: 701_892)
  end
end
