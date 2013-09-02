require "helper"

describe Kounta::REST::Client do

	subject { Kounta::REST::Client }

	it "should be able to create a new client" do
		subject.new.should be_an_instance_of(Kounta::REST::Client)
	end

end