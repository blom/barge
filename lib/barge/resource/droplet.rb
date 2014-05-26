module Barge
  module Resource
    class Droplet
      include Resource::Base

      def create(options)
        request(:post, 'droplets', options.to_json)
      end

      def all
        request(:get, 'droplets')
      end

      def show(droplet_id)
        request(:get, "droplets/#{droplet_id}")
      end

      def destroy(droplet_id)
        request(:delete, "droplets/#{droplet_id}")
      end

      def rename(droplet_id, name)
        action(droplet_id, __method__, name: name)
      end

      def reboot(droplet_id)
        action(droplet_id, __method__)
      end

      def power_off(droplet_id)
        action(droplet_id, __method__)
      end

      def power_cycle(droplet_id)
        action(droplet_id, __method__)
      end

      def power_on(droplet_id)
        action(droplet_id, __method__)
      end

      def resize(droplet_id, size)
        action(droplet_id, __method__, size: size)
      end

      def rebuild(droplet_id, image)
        action(droplet_id, __method__, image: image)
      end

      def restore(droplet_id, image)
        action(droplet_id, __method__, image: image)
      end

      def shutdown(droplet_id)
        action(droplet_id, __method__)
      end

      def password_reset(droplet_id)
        action(droplet_id, __method__)
      end

      private

      def action(droplet_id, type, params = {})
        request(:post, "droplets/#{droplet_id}/actions",
                { type: type, params: params }.to_json)
      end
    end
  end
end
