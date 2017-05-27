require './lib/kounta'
require 'pry'

tokens = YAML.safe_load(File.open('./tokens.yml'))

Kounta.configure do |config|
  config.client_id = tokens['client_id']
  config.client_secret = tokens['client_secret']
  config.client_token = tokens['client_token']
  config.client_refresh_token = tokens['client_refresh_token']
  config.enable_logging = true
end

Pry.start
