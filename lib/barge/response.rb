require 'forwardable'

module Barge
  class Response < Hashie::Mash
    extend Forwardable

    attr_reader :response
    def_delegator :response, :success?, :success?

    def initialize(faraday_response)
      @response = faraday_response
      super(faraday_response.body)
    end

    def paginated?
      !(links && links.pages).nil?
    end

    def prev_page
      extract_page(:prev)
    end

    def next_page
      extract_page(:next)
    end

    def last_page
      extract_page(:last)
    end

    private

    def extract_page(key)
      return unless paginated? && links.pages.key?(key)
      Integer links.pages[key][/page=(\d+)/, 1]
    end
  end
end
