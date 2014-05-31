module Barge
  module Resource
    class Size
      include Resource::Base

      def all
        get('sizes')
      end
    end
  end
end
