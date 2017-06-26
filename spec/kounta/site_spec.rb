require 'helper'

describe Kounta::Site do
  subject { Kounta::Company.new(@client).site(985) }

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(companies: 162, sites: 923)
  end
end
