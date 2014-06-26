module Barge
  module Resource
    class Action
      include Resource::Base

      def all
        get('actions')
      end

      def show(action_id)
        get("actions/#{action_id}")
      end
    end
  end
end
