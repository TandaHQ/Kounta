# Kounta

Allows easy access to the Kounta POS RESTful API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kounta_rest'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install kounta_rest
```

## Usage

```ruby
require 'kounta'
```

### Multi-legged OAuth

If you've already got an OAuth access token, feel free to skip to API Client Setup.

The Kounta API uses 3 legged OAuth2. Here's an example controller you can use to authenticate:

```ruby
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
```

### API Client Setup

Use the gem by creating a Kounta client:

```ruby
company = Kounta::REST::Client.new({
  :consumer => {
    :key    => YOUR_CONSUMER_KEY,
    :secret => YOUR_CONSUMER_SECRET,
  },
  :access_token => YOUR_OAUTH_ACCESS_TOKEN
}).company
```

This will automatically download data about the company associated with your authentication details.

From here you can start to fetch relationships of that data, e.g. for all the sites belonging to your company

```ruby
sites = company.sites
```

For the products belonging to a site

```ruby
sites.first.products
```

Please see the test suite for full details of these.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
