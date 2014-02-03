# Kounta

Allows easy access to the Kounta POS RESTful API.

## Installation

Add this line to your application's Gemfile:

    gem 'kounta_rest'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kounta_rest

## Usage

    require 'kounta'

### Multi-legged OAuth

If you've already got an OAuth access token, feel free to skip to API Client Setup.

The Kounta API uses 3 legged OAuth2. Here's an example controller you can use to authenticate:

    class KountaSessionController  
      def new
        redirect_to kounta_client.get_access_code_url
      end

      def create
        token = kounta_client.get_access_token(params[:code])
        kounta_client.company.sites # start loading data from the client
      end

      def kounta_client
        @kounta_client ||= Kounta::REST::Client.new({
          :redirect_url => YOUR_REDIRECT_URL,
          :consumer => {
            :key    => YOUR_CONSUMER_KEY,
            :secret => YOUR_CONSUMER_SECRET,
          },
        })
      end
    end

### API Client Setup

Use the gem by creating a Kounta client:

    company = Kounta::REST::Client.new({
          :consumer => {
            :key    => YOUR_CONSUMER_KEY,
            :secret => YOUR_CONSUMER_SECRET,
          },
          :access_token => YOUR_OAUTH_ACCESS_TOKEN
        }).company

This will automatically download data about the company associated with your authentication details.

From here you can start to fetch relationships of that data, e.g. for all the sites belonging to your company

    sites = company.sites

For the products belonging to a site

    sites.first.products

Please see the test suite for full details of these.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
