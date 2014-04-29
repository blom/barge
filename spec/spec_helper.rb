if ENV['SIMPLECOV']
  require 'simplecov'
  SimpleCov.start { add_filter '/spec/' }
end

require_relative '../lib/barge'
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

require 'webmock/rspec'

RSpec.configure do |config|
  config
end
