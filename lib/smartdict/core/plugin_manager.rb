class Smartdict::Core::PluginManager
  include Smartdict::Core::IsManager

  def self.load_plugins
    require_plugins
    run_initializers
  end


  private

  def self.require_plugins
    Dir["#{Smartdict.plugins_dir}/*"].each do |plugin_dir|
      plugin_name = File.basename plugin_dir
      require_plugin(plugin_name)
    end
  end

  def self.require_plugin(plugin_name)
    $LOAD_PATH << "#{Smartdict.plugins_dir}/#{plugin_name}/lib"
    require plugin_name
  rescue LoadError
    log.error "Can't load plugin `#{plugin_name}` from directory #{Smartdict.plugins_dir}"
    $LOAD_PATH.pop
  end

  def self.run_initializers
    all.each do |name, data|
      Smartdict::Plugin::InitializerContext.new.instance_eval &data[:block]
    end
  end
end
