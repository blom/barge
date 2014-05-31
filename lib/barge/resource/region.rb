module Barge
  module Resource
    class Region
      include Resource::Base

      def all
        get('regions')
      end
    end
  end
end
