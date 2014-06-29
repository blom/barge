module Barge
  module Resource
    module Base
      attr_reader :faraday

      PER_PAGE = 999

      def initialize(faraday)
        @faraday = faraday
      end

      private

      [:delete, :get, :head, :post, :put].each do |verb|
        define_method verb do |*args|
          request(__method__, *args)
        end
      end

      def request(verb, *args)
        options = { per_page: PER_PAGE } if verb == :get
        response = faraday.public_send(verb, *args, options)
        response.body.tap do |r|
          r.define_singleton_method(:response) { response }
          r.define_singleton_method(:success?) { response.success? }
        end
      end
    end
  end
end
