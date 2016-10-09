source 'https://rubygems.org'
gemspec

gem 'coveralls', '0.8.11', require: false
gem 'term-ansicolor', '1.3.2'
gem 'guard'
gem 'guard-rspec'
gem 'rake'
gem 'rspec'
gem 'rubocop', '~> 0.34.0'
gem 'simplecov'
gem 'webmock', require: false
gem 'yard'
gem 'listen', '<= 3.0.6', require: false
gem 'json_pure', '<= 2.0.1' if RUBY_VERSION < '2.0.0'

platforms :jruby do
  gem 'kramdown'
end

platforms :rbx do
  gem 'rubysl'
end

platforms :ruby do
  gem 'github-markup'
  gem 'redcarpet'
end
