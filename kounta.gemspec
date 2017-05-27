# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kounta/version'

Gem::Specification.new do |spec|
  spec.name          = 'kounta_rest'
  spec.version       = Kounta::VERSION
  spec.authors       = ['Samuel Richardson']
  spec.email         = ['sam@richardson.co.nz']
  spec.description   = "Library for accessing Kounta's RESTful API"
  spec.summary       = "A wrapper around Kounta's RESTful API"
  spec.homepage      = 'https://github.com/Rodeoclash/Kounta'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '0.7.1'
  spec.add_development_dependency 'webmock', '~> 3.0.0'
  spec.add_development_dependency 'pry', '0.9.12.2'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'

  spec.add_dependency 'oj', '~> 2'
  spec.add_dependency 'hashie', '~> 2'
  spec.add_dependency 'oauth2', '~> 1'
  spec.add_dependency 'faraday_middleware', '~> 0.9'
end
