module Barge
  module Resource
    class Image
      include Resource::Base

      def all
        get('images')
      end

      def show(image_id)
        get("images/#{image_id}")
      end

      def update(image_id, options)
        put("images/#{image_id}", options.to_json)
      end

      def destroy(image_id)
        delete("images/#{image_id}")
      end

      def transfer(image_id, region)
        action(image_id, __method__, region: region)
      end

      def show_action(image_id, action_id)
        get("images/#{image_id}/actions/#{action_id}")
      end

      private

      def action(image_id, type, params = {})
        post("images/#{image_id}/actions",
             { type: type, params: params }.to_json)
      end
    end
  end
end
