require 'rubygems'

require 'active_support/core_ext/class'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

module Smartdict; end

require 'configatron'
require "smartdict/core"
require "smartdict/commands"
require "smartdict/models"


module Smartdict
  class Error < ::Exception; end

  ENVIRONMENTS = [:user, :test, :cucumber]

  class << self
    include Smartdict::Core

    def run
      init_config
      Core::PluginManager.load_plugins!
      Dir.mkdir user_dir unless File.exists?(user_dir) 
      setup_dm
    end

    def plugin_manager
      @plugin_manager ||= Core::PluginManager.new(plugins_dir)
    end

    def init_config
      default_config_file = File.join(root_dir, 'config', 'default_config.yml')
      configatron.configure_from_hash YAML.load_file(default_config_file)

      config_file = File.join(user_dir, 'configuration.yml')
      configatron.configure_from_hash YAML.load_file(config_file)

      configatron.plugins_dir = File.join(root_dir, 'plugins')
      configatron.store.db = File.join(user_dir, 'database.sqlite')
    end


    def user_dir
      dirname = {
        :user     => '.smartdict',
        :test     => '.smartdict_test', 
        :cucumber => '.smartdict_test' }[env]
      File.join(home_dir, dirname) 
    end

    def home_dir
      ENV['HOME']
    end


    def env=(environment)
      @env = environment.to_sym
      raise "env must be one of #{ENVIRONMENTS.inspect}" unless ENVIRONMENTS.include?(@env)
    end

    def env
      @env || raise("No env setted for Smartdict")
    end

    def log_path
      File.join(user_dir, 'smartdict.log')
    end

    def root_dir
      File.join(File.dirname(__FILE__), '..')
    end

    def plugins_dir
      File.join(root_dir, 'plugins')
    end


    private

    def setup_dm
      case configatron.store.adapter
      when 'sqlite'
        db = configatron.store.db
        db_adapted = (db == 'memory') ? ":#{db}:" : "//#{db}"
        DataMapper.setup(:default, "sqlite:#{db_adapted}")
        if db == 'memory' or !File.exists?(db)
          DataMapper.finalize
          DataMapper.auto_migrate!
        end
      else
        raise "Not supported adapter #{configatron.store.adapter}" 
      end
    end

  end
end
