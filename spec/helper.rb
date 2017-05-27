require 'simplecov'
SimpleCov.start

require 'rspec'
require 'webmock/rspec'
require 'kounta'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include Helpers

  config.before(:each) do
    stub_endpoints

    Kounta.configure do |c|
      c.client_id = '1234'
      c.client_secret = '5678'
      c.client_token = 'abcd'
      c.client_refresh_token = 'efgh'
    end
  end
end
