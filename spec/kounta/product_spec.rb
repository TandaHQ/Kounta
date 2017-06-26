require 'helper'

describe Kounta::Product do
  subject { Kounta::Company.new(@client).site(985).product(1) }

  it 'should be able to to test for tags' do
    expect(subject.tags_include?('Rosebud')).to be(false)
    expect(subject.tags_include?('Fragile')).to be(true)
  end

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(companies: 162, products: 1)
  end
end
