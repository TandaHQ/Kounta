require 'helper'

describe Kounta::Category do
  subject { Kounta::Company.new(@client).category(1) }

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(companies: 162, categories: 1)
  end
end
