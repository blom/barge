module Barge
  module Resource
    class Key
      include Resource::Base

      def create(options)
        request(:post, 'account/keys', options.to_json)
      end

      def all
        request(:get, 'account/keys')
      end

      def show(key_id)
        request(:get, "account/keys/#{key_id}")
      end

      def destroy(key_id)
        request(:delete, "account/keys/#{key_id}")
      end
    end
  end
end
