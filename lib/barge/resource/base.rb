module Barge
  module Resource
    module Base
      attr_reader :faraday

      def initialize(faraday)
        @faraday = faraday
      end

      private

      def request(verb, *args)
        response = faraday.public_send(verb, *args)
        response.body.tap do |r|
          r.define_singleton_method(:response) { response }
          r.define_singleton_method(:success?) { response.success? }
        end
      end
    end
  end
end
