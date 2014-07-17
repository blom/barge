module Barge
  module Resource
    module Base
      attr_reader :faraday

      PER_PAGE = 200

      def initialize(faraday)
        @faraday = faraday
      end

      private

      [:delete, :get, :head, :post, :put].each do |verb|
        define_method verb do |*args|
          request(__method__, *args)
        end
      end

      def request(verb, path, options = {})
        options = { per_page: PER_PAGE }.merge(options) if verb == :get
        Response.new faraday.public_send(verb, path, options)
      end
    end
  end
end
