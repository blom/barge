if ENV['SIMPLECOV']
  require 'simplecov'
  SimpleCov.start { add_filter '/spec/' }
end

require_relative '../lib/barge'

require 'webmock/rspec'

RSpec.configure do |config|
  config
end
