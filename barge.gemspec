require File.expand_path '../lib/barge/version', __FILE__

Gem::Specification.new do |spec|
  spec.name        = 'barge'
  spec.version     = Barge::Version
  spec.summary     = 'Barge'
  spec.description = 'Barge'
  spec.license     = 'MIT'
  spec.authors     = ['']
  spec.email       = ''
  spec.homepage    = ''
  spec.files       = Dir['lib/**/*.rb', '[A-Z][A-Z]*']

  spec.required_ruby_version = '>= 1.9.2'

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'hashie',  '~> 2.1'
end
