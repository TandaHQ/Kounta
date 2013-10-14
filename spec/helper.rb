require 'simplecov'
SimpleCov.start

require 'rspec'
require 'webmock/rspec'
require 'kounta'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
	config.include Helpers

	config.before(:each) do
		
		stub_endpoints

		Kounta.configure do |config|
			config.client_id = "1234"
			config.client_secret = "5678"
			config.client_token = "abcd"
			config.client_refresh_token = "efgh"
		end

	end

end