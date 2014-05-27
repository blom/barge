module Barge
  module Resource
    class Size
      include Resource::Base

      def all
        request(:get, 'sizes')
      end
    end
  end
end
