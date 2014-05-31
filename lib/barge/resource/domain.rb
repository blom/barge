module Barge
  module Resource
    class Domain
      include Resource::Base

      def create(options)
        post('domains', options.to_json)
      end

      def all
        get('domains')
      end

      def show(domain_name)
        get("domains/#{domain_name}")
      end

      def destroy(domain_name)
        delete("domains/#{domain_name}")
      end

      def create_record(domain_name, options)
        post("domains/#{domain_name}/records", options.to_json)
      end

      def records(domain_name)
        get("domains/#{domain_name}/records")
      end

      def show_record(domain_name, record_id)
        get("domains/#{domain_name}/records/#{record_id}")
      end

      def update_record(domain_name, record_id, options)
        put("domains/#{domain_name}/records/#{record_id}", options.to_json)
      end

      def destroy_record(domain_name, record_id)
        delete("domains/#{domain_name}/records/#{record_id}")
      end
    end
  end
end
