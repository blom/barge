module Barge
  module Resource
    class Image
      include Resource::Base

      def all
        request(:get, 'images')
      end

      def show(image_id)
        request(:get, "images/#{image_id}")
      end

      def update(image_id, options)
        request(:put, "images/#{image_id}", options.to_json)
      end

      def destroy(image_id)
        request(:delete, "images/#{image_id}")
      end

      def transfer(image_id, region)
        action(image_id, __method__, region: region)
      end

      private

      def action(image_id, type, params = {})
        request(:post, "images/#{image_id}/actions",
                { type: type, params: params }.to_json)
      end
    end
  end
end
