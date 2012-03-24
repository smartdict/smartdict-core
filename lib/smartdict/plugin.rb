class Smartdict::Plugin
  extend ActiveSupport::Autoload

  autoload :InitializerContext

  def self.initializer(name, options = {}, &block)
    Smartdict::Core::PluginManager.register(name, :options => options, :block => block)
  end
end
