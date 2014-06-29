module Barge
  module Resource
    class Key
      include Resource::Base

      def create(options)
        post('account/keys', options.to_json)
      end

      def all
        get('account/keys')
      end

      def show(key_id)
        get("account/keys/#{key_id}")
      end

      def update(key_id, options)
        put("account/keys/#{key_id}", options.to_json)
      end

      def destroy(key_id)
        delete("account/keys/#{key_id}")
      end
    end
  end
end
