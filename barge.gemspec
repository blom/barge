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

  spec.add_dependency 'faraday', '~> 0.9.0'

  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'kramdown'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0.0.beta2'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'yard'
end
