module Barge
  module Resource
    class Volume
      include Resource::Base

      def create(options)
        post('volumes', options.to_json)
      end

      def all(options = {})
        get('volumes', options)
      end

      def show(volume_id)
        get("volumes/#{volume_id}")
      end

      def destroy(volume_id)
        delete("volumes/#{volume_id}")
      end

      def create_record(volume_id, options)
        post("volumes/#{volume_id}/records", options.to_json)
      end

      def records(volume_id, options = {})
        get("volumes/#{volume_id}/records", options)
      end

      def show_record(volume_id, record_id)
        get("volumes/#{volume_id}/records/#{record_id}")
      end

      def update_record(volume_id, record_id, options)
        put("volumes/#{volume_id}/records/#{record_id}", options.to_json)
      end

      def destroy_record(volume_id, record_id)
        delete("volumes/#{volume_id}/records/#{record_id}")
      end
    end
  end
end
