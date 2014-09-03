require 'coveralls'

if ENV['SIMPLECOV']
  require 'simplecov'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start do
    coverage_dir('coverage/')
  end
elsif ENV['TRAVIS'] && RUBY_ENGINE == 'ruby'
  require 'coveralls'
  Coveralls.wear! { add_filter '/spec/' }
end

require_relative '../lib/barge'
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

require 'webmock/rspec'
WebMock.disable_net_connect!(allow: 'coveralls.io')

RSpec.configure do |config|
  config.include SpecHelpers
  config.raise_errors_for_deprecations!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |c|
    c.syntax = :expect
    c.verify_partial_doubles = true
  end
end
