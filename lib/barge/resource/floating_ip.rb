module Barge
  module Resource
    class FloatingIP
      include Resource::Base

      def all(options = {})
        get('floating_ips', options)
      end

      def create(options)
        post('floating_ips', options.to_json)
      end

      def show(ip_address)
        get("floating_ips/#{ip_address}")
      end

      def destroy(ip_address)
        delete("floating_ips/#{ip_address}")
      end

      def assign(ip_address, options)
        action(ip_address, __method__, options)
      end

      def unassign(ip_address)
        action(ip_address, __method__)
      end

      private

      def action(ip_address, type, params = {})
        post("floating_ips/#{ip_address}/actions",
             { type: type }.merge(params).to_json)
      end
    end
  end
end
