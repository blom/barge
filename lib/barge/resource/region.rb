module Barge
  module Resource
    class Region
      include Resource::Base

      def all
        request(:get, 'regions')
      end
    end
  end
end
