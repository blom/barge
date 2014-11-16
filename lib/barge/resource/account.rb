module Barge
  module Resource
    class Account
      include Resource::Base

      def show
        get('account')
      end
    end
  end
end
