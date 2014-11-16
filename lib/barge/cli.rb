require 'etc'
require 'yaml'

module Barge
  class CLI
    attr_accessor :barge
    attr_accessor :resource
    attr_accessor :action
    attr_accessor :options

    def initialize(argv)
      self.barge    = Barge::Client.new(access_token: access_token)
      self.resource = argv.shift
      self.action   = argv.shift
      self.options  = if argv.size == 1
                        argv.shift
                      else
                        Hash[*argv.map { |n| n.tr '--', '' }]
                      end

      output dispatch
    end

    private

    def access_token
      config['access_token']
    end

    def config
      @config ||= YAML.load_file(config_file)
    end

    def config_file
      File.join(Dir.home(Etc.getlogin), '.barge')
    end

    def dispatch
      barge.public_send(resource).public_send(action, options)
    end

    def output(response)
      puts JSON.pretty_generate(response)
      exit response.success? ? 0 : 1
    end
  end
end
