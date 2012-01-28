class Smartdict::Core::PluginManager
  include Singleton 
  include Smartdict::Core::HasLogger

  def initialize
    @plugins = {}
  end

  def load_plugins
    require_plugins
    run_initializers
  end

  def register_plugin(name, options, block)
    raise Smartdict::Error.new("Plugin #{name} is already registed") if @plugins[name.to_s]
    @plugins[name.to_s] = {:block => block, :options => options}
  end


  private 

  def require_plugins
    Dir["#{Smartdict.plugins_dir}/*"].each do |plugin_dir|
      plugin_name = File.basename plugin_dir
      require_plugin(plugin_name)
    end
  end

  def require_plugin(plugin_name)
    $LOAD_PATH << "#{Smartdict.plugins_dir}/#{plugin_name}/lib"
    require plugin_name
  rescue LoadError
    log.error "Can't load plugin `#{plugin_name}` from directory #{Smartdict.plugins_dir}"
    $LOAD_PATH.pop
  end

  def run_initializers
    @plugins.each do |name, data|
      Smartdict::Plugin::InitializerContext.new.instance_eval &data[:block]
    end
  end

end
