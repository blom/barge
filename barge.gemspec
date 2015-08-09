# encoding: UTF-8
require File.expand_path '../lib/barge/version', __FILE__

Gem::Specification.new do |spec|
  spec.name        = 'barge'
  spec.version     = Barge::Version
  spec.summary     = 'Ruby library for DigitalOcean'
  spec.description = "Ruby library for version 2 of DigitalOcean's API"
  spec.license     = 'MIT'
  spec.authors     = ['Ørjan Blom']
  spec.email       = %w(blom@blom.tv)
  spec.homepage    = 'https://github.com/blom/barge'
  spec.files       = Dir['lib/**/*.rb', '[A-Z][A-Z]*']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'faraday',            '~> 0.9'
  spec.add_dependency 'faraday_middleware', '~> 0.10'
  spec.add_dependency 'hashie',             '~> 3.4'
end
