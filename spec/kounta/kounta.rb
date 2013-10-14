require "helper"

describe Kounta do

	subject { Kounta }

	it "should be able to call a configure block" do
		subject.configure do |config|
			config.should be(Kounta)
		end
	end

end