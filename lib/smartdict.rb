require 'rubygems'
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

module Smartdict; end

require "smartdict/core"
require "smartdict/models"


module Smartdict
  ENVIRONMENTS = [:user, :test, :cucumber]

  class << self
    include Smartdict::Core

    attr_reader :conf

    def run
      configure
      Dir.mkdir user_dir unless FileTest.exists?(user_dir) 
      @conf.save! unless FileTest.exists?(conf_file)
      setup_dm
    end

    def plugin_manager
      @plugin_manager ||= Core::PluginManager.new(plugins_dir)
    end

    def conf_file
      File.join(user_dir, 'configuration.yml')
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

    def configure
      @conf ||= Conf.init
      yield(@conf) if block_given?
      @conf
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
      case conf.store.adapter
      when 'sqlite'
        db = conf.store.db
        db_adapted = (db == 'memory') ? ":#{db}:" : "//#{db}"
        DataMapper.setup(:default, "sqlite:#{db_adapted}")
        if db == 'memory' or !File.exists?(db)
          DataMapper.finalize
          DataMapper.auto_migrate!
        end
      else
        raise "Not supported adapter #{conf.store.adapter}" 
      end
    end

  end
end
