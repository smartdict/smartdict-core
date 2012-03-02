require 'rubygems'

require 'dm-core'
require 'dm-validations'
require 'dm-enum'
require 'dm-migrations'
require 'dm-sqlite-adapter'
require 'active_support/core_ext/class'
require 'active_support/core_ext/object'
require 'active_support/dependencies/autoload'
require 'configatron'
require 'net/http'

require 'smartdict/errors'
require 'smartdict/models'



module Smartdict
  extend self
  extend ActiveSupport::Autoload

  autoload :Core
  autoload :Models
  autoload :Plugin
  autoload :Commands
  autoload :Drivers
  autoload :Translator
  autoload :Seeder
  autoload :Formats
  autoload :Translation
  autoload :ListBuilder

  include Smartdict::Core

  ENVIRONMENTS = [:user, :test, :cucumber]
  VERSION = "0.0.0"


  def load_plugins
    Core::PluginManager.instance.load_plugins
  end

  def run
    init_config
    Dir.mkdir user_dir unless File.exists?(user_dir)
    setup_dm
  end

  def init_config
    default_config_file = File.join(root_dir, 'config', 'default_config.yml')
    configatron.configure_from_hash YAML.load_file(default_config_file)

    config_file = File.join(user_dir, 'configuration.yml')
    if File.exists?(config_file)
      configatron.configure_from_hash YAML.load_file(config_file)
    else
      FileUtils.cp default_config_file, config_file
    end
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
    ENV['SMARTDICT_PLUGINS_DIR'] or File.join(root_dir, 'plugins')
  end


  private


  def setup_dm
    #DataMapper::Logger.new(STDOUT, :debug)
    setup_sqlite
  end

  def setup_sqlite
    store = (env == :test) ? ":memory:" : "//#{db_file}"
    DataMapper.setup(:default, "sqlite:#{store}")
    DataMapper.finalize
    if store =~ /memory/ or !File.exists?(db_file)
      DataMapper.auto_migrate!
      Seeder.seed!
    end

    Models::Language.update_enums_cache!
    Models::Driver.update_enums_cache!
    Models::WordClass.update_enums_cache!
  end

  def db_file
    "#{user_dir}/database.sqlite"
  end
end
