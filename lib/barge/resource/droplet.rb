module Barge
  module Resource
    class Droplet
      include Resource::Base

      def show(droplet_id)
        request(:get, "/droplets/#{droplet_id}")
      end
    end
  end
end
