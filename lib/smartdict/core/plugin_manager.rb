class Smartdict::Core::PluginManager
  include Smartdict::Core::HasLog

  def initialize(plugins_dir)
    @plugins_dir = plugins_dir
  end

  def load_plugins
    Smartdict.conf.plugins.each do |plugin|
      load_plugin(plugin)
    end
  end


  private

  def load_plugin(name)
    log.info "Loading #{name} plugin"
    require plugin_file_path(name)
  rescue LoadError 
    begin
      require "smartdict/plugins/#{name}"
    rescue LoadError
      log.error "Plugin #{name} not found in plugins dir or rubygems"
    end
  end

  def plugin_file_path(plugin_name)
    File.join(@plugins_dir, plugin_name, 'lib', plugin_name)
  end

end
