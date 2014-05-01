source 'https://rubygems.org'
gemspec

gem 'rake'
gem 'rspec', '~> 3.0.0.beta2'
gem 'rubocop'
gem 'simplecov'
gem 'webmock'
gem 'yard'

if RUBY_VERSION.to_f >= 2
  gem 'guard'
  gem 'guard-rspec'
end

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
