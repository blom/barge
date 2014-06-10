module Barge
  module Resource
    class Droplet
      include Resource::Base

      def create(options)
        post('droplets', options.to_json)
      end

      def all
        get('droplets')
      end

      def show(droplet_id)
        get("droplets/#{droplet_id}")
      end

      def backups(droplet_id)
        get("droplets/#{droplet_id}/backups")
      end

      def destroy(droplet_id)
        delete("droplets/#{droplet_id}")
      end

      def rename(droplet_id, name)
        action(droplet_id, __method__, name: name)
      end

      def reboot(droplet_id)
        action(droplet_id, __method__)
      end

      def shutdown(droplet_id)
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

      def rebuild(droplet_id, image_id)
        action(droplet_id, __method__, image: image_id)
      end

      def restore(droplet_id, image_id)
        action(droplet_id, __method__, image: image_id)
      end

      def password_reset(droplet_id)
        action(droplet_id, __method__)
      end

      def show_action(droplet_id, action_id)
        get("droplets/#{droplet_id}/actions/#{action_id}")
      end

      private

      def action(droplet_id, type, params = {})
        post("droplets/#{droplet_id}/actions",
             { type: type, params: params }.to_json)
      end
    end
  end
end
