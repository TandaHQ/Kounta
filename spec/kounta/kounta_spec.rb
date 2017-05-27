require 'helper'

describe Kounta do
  subject { Kounta }

  it 'should be able to call a configure block' do
    subject.configure do |config|
      expect(config).to be(Kounta)
    end
  end

  it 'should be able to configure logging' do
    expect(Kounta.enable_logging).to be(false)
    Kounta.enable_logging = true
    expect(Kounta.enable_logging).to be(true)
    Kounta.enable_logging = false
    expect(Kounta.enable_logging).to be(false)
  end
end
