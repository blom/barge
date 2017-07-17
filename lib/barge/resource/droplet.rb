module Barge
  module Resource
    class Droplet
      include Resource::Base

      def create(options)
        post('droplets', options.to_json)
      end

      def all(options = {})
        get('droplets', options)
      end

      def show(droplet_id)
        get("droplets/#{droplet_id}")
      end

      def backups(droplet_id)
        get("droplets/#{droplet_id}/backups")
      end

      def kernels(droplet_id)
        get("droplets/#{droplet_id}/kernels")
      end

      def snapshots(droplet_id)
        get("droplets/#{droplet_id}/snapshots")
      end

      def destroy(droplet_id)
        delete("droplets/#{droplet_id}")
      end

      def rename(droplet_id, options)
        action(droplet_id, __method__, options)
      end

      def snapshot(droplet_id, options)
        action(droplet_id, __method__, options)
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

      def resize(droplet_id, options)
        action(droplet_id, __method__, options)
      end

      def rebuild(droplet_id, options)
        action(droplet_id, __method__, options)
      end

      def restore(droplet_id, options)
        action(droplet_id, __method__, options)
      end

      def password_reset(droplet_id)
        action(droplet_id, __method__)
      end

      def change_kernel(droplet_id, options)
        action(droplet_id, __method__, options)
      end

      def enable_ipv6(droplet_id)
        action(droplet_id, __method__)
      end

      def enable_backups(droplet_id)
        action(droplet_id, __method__)
      end

      def disable_backups(droplet_id)
        action(droplet_id, __method__)
      end

      def enable_private_networking(droplet_id)
        action(droplet_id, __method__)
      end

      def actions(droplet_id)
        get("droplets/#{droplet_id}/actions")
      end

      def show_action(droplet_id, action_id)
        get("droplets/#{droplet_id}/actions/#{action_id}")
      end

      private

      def action(droplet_id, type, params = {})
        post("droplets/#{droplet_id}/actions",
             { type: type }.merge(params).to_json)
      end
    end
  end
end
