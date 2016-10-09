module Barge
  module Resource
    class Snapshot
      include Resource::Base

      def all(options = {})
        get('snapshots', options)
      end

      def show(snapshot_id)
        get("snapshots/#{snapshot_id}")
      end

      def destroy(snapshot_id)
        delete("snapshots/#{snapshot_id}")
      end

    end
  end
end
