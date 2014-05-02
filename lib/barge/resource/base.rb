module Barge
  module Resource
    module Base
      attr_reader :faraday

      def initialize(faraday)
        @faraday = faraday
      end

      private

      def request(verb, *args)
        Hashie::Mash.new JSON.parse(faraday.public_send(verb, *args).body)
      end
    end
  end
end
