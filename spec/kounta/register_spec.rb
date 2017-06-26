require 'helper'

describe Kounta::Register do
  subject { Kounta::Company.new(@client).register(9_091) }

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(companies: 162, registers: 9_091)
  end

  it 'should be a listable resource' do
    expect(Kounta::Company.new(@client).registers.map(&:resource_path))
      .to eq([
               { companies: 162, registers: 9091 },
               { companies: 162, registers: 9085 }
             ])
  end
end
