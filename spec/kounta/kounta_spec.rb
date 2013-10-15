require "helper"

describe Kounta do

	subject { Kounta }

	it "should be able to call a configure block" do
		subject.configure do |config|
			config.should be(Kounta)
		end
	end

	it "should be able to configure loggin" do
		Kounta.enable_logging.should be(false)
		Kounta.enable_logging = true
		Kounta.enable_logging.should be(true)
		Kounta.enable_logging = false
		Kounta.enable_logging.should be(false)
	end

end