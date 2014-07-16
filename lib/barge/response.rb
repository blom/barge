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
  end
end
