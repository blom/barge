module Barge
  module Resource
    class Image
      include Resource::Base

      def all
        response = get('images')
        returned_response = response
        while response.links && response.links.pages && response.links.pages.next
          link = response.links.pages.next.sub(Barge::Client::DIGITAL_OCEAN_URL + '/', '')
          response = get(link)
          returned_response.images += response.images
        end
        returned_response
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
