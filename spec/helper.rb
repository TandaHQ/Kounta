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

    @client = Kounta::REST::Client.new(
      redirect_uri: nil,
      consumer: {
        key: '1234',
        secret: '5678'
      },
      access_token: 'abcd',
      refresh_token: 'efgh'
    )
  end
end
