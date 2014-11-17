require 'faraday'
require 'faraday_middleware'

module Barge
  class Client
    attr_accessor :access_token
    attr_accessor :request_options

    attr_reader :account
    attr_reader :action
    attr_reader :domain
    attr_reader :droplet
    attr_reader :image
    attr_reader :key
    attr_reader :region
    attr_reader :size

    DEFAULT_OPTIONS = {}
    DIGITAL_OCEAN_URL = 'https://api.digitalocean.com/v2'
    TIMEOUTS = 10

    def initialize(options = DEFAULT_OPTIONS)
      self.access_token = options.fetch(:access_token, nil)
      self.request_options =
        { open_timeout: TIMEOUTS, timeout: TIMEOUTS }
        .merge(options.fetch(:request_options, {}))
      yield(self) if block_given?
      fail ArgumentError, 'missing access_token' unless access_token
      initialize_resources
    end

    private

    def initialize_resources
      @account = Resource::Account.new(faraday)
      @action  = Resource::Action.new(faraday)
      @domain  = Resource::Domain.new(faraday)
      @droplet = Resource::Droplet.new(faraday)
      @image   = Resource::Image.new(faraday)
      @key     = Resource::Key.new(faraday)
      @region  = Resource::Region.new(faraday)
      @size    = Resource::Size.new(faraday)
    end

    def faraday
      @faraday ||= Faraday.new faraday_options do |f|
        f.adapter :net_http

        f.request :json

        f.response :follow_redirects
        f.response :mashify
        f.response :json

        f.options.merge! request_options
      end
    end

    def faraday_options
      {
        headers: {
          authorization: "Bearer #{access_token}",
          content_type: 'application/json'
        },
        url: DIGITAL_OCEAN_URL
      }
    end
  end
end
