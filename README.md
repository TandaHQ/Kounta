# Kounta

Allows easy access to the Kounta POS RESTful API.

## Installation

Add this line to your application's Gemfile:

    gem 'kounta'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kounta

## Usage

    require 'kounta'

Then add your API details / other configuration options

Kounta.configure do |config|
    config.client_id = "abcd1234"
    config.client_secret = "abcd1234"
    config.client_token = "abcd1234"
    config.client_refresh_token = "abcd1234"
end

You may also enable / disable logging (disabled by default)

    config.enable_logging = true

Use the gem by creating a Kounta company object:

    company = Kounta::Company.new

This will automatically download data about the company associated with your authentication details.

From here you can start to fetch relationships of that data, e.g. for all the sites belonging to your company

    sites = company.sites

For the products belonging to a site

    sites.first.products

Please see the test sweet for full details of these.

### Console

To aid debugging their is an interactive console. To get started, you'll need to create a "tokens.yml" file in the root of gem, like:

    client_id: abcd1234
    client_secret: abcd1234
    client_token: abcd1234
    client_refresh_token: abcd1234

Then run:

    ruby console.rb

Get started by creating a Kounta::Company object (see above for detailed usage).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
