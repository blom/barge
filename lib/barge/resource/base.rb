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
        process_response(response).tap do |r|
          r.define_singleton_method(:response) { response }
          r.define_singleton_method(:success?) { response.success? }
        end
      end

      def process_response(response)
        if response.body.kind_of?(Array)
          response.body.map { |entry| Hashie::Mash.new(entry) }
        else
          Hashie::Mash.new(response.body)
        end
      end
    end
  end
end
