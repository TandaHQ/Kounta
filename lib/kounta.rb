require_relative 'kounta/version'
require_relative 'kounta/errors'
require_relative 'kounta/rest/client'
require_relative 'kounta/resource'
require_relative 'kounta/category'
require_relative 'kounta/tax'
require_relative 'kounta/product'
require_relative 'kounta/address'
require_relative 'kounta/payment'
require_relative 'kounta/line'
require_relative 'kounta/order'
require_relative 'kounta/person'
require_relative 'kounta/customer'
require_relative 'kounta/register'
require_relative 'kounta/price_list'
require_relative 'kounta/inventory'
require_relative 'kounta/break'
require_relative 'kounta/shift'
require_relative 'kounta/site'
require_relative 'kounta/staff'
require_relative 'kounta/webhook'

# require this one last as it depends on the rest
require_relative 'kounta/company'

module Kounta
  AUTHORIZATION_URI = 'https://my.kounta.com/authorize'.freeze
  TOKEN_URI = 'https://api.kounta.com/v1/token.json'.freeze
  SITE_URI = 'https://api.kounta.com/v1/'.freeze
  FORMAT = :json

  def self.format_date(date)
    date.respond_to?(:strftime) ? date.strftime('%Y-%m-%d') : date.to_s
  end

  def self.log(_message); end

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.configure
    yield self
  end

  def self.enable_logging=(value)
    @enable_logging = value
  end

  def self.enable_logging
    @enable_logging || false
  end
end
