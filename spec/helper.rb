require 'simplecov'
SimpleCov.start

require 'kounta'
require 'rspec'
require 'webmock/rspec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
	config.include Helpers
	config.before(:each) do
		stub_endpoints
	end
end