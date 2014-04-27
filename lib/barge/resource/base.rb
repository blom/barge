module Barge
  module Resource
    module Base
      attr_reader :faraday

      def initialize(faraday)
        @faraday = faraday
      end
    end
  end
end
