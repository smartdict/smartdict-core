class Smartdict::Plugin::InitializerContext
  include Smartdict::Core

  def register_command(name, command_class)
    CommandManager.register(name, command_class)
  end
end
