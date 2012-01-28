class Smartdict::Plugin
  extend ActiveSupport::Autoload

  autoload :InitializerContext

  def self.initializer(name, options = {}, &block)
    Smartdict::Core::PluginManager.instance.register_plugin(name, options, block)
  end
end
