require 'faraday'
require 'faraday_middleware'

module Barge
  class Client
    attr_accessor :access_token
    attr_accessor :request_options

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
    end

    def account
      @account ||= Resource::Account.new(faraday)
    end

    def action
      @action ||= Resource::Action.new(faraday)
    end

    def domain
      @domain ||= Resource::Domain.new(faraday)
    end

    def droplet
      @droplet ||= Resource::Droplet.new(faraday)
    end

    def image
      @image ||= Resource::Image.new(faraday)
    end

    def key
      @key ||= Resource::Key.new(faraday)
    end

    def region
      @region ||= Resource::Region.new(faraday)
    end

    def size
      @size ||= Resource::Size.new(faraday)
    end

    def floating_ip
      @floating_ip ||= Resource::FloatingIP.new(faraday)
    end

    def volume
      @volume ||= Resource::Volume.new(faraday)
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

    private

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
