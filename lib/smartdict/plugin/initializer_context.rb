class Smartdict::Plugin::InitializerContext
  include Smartdict::Core

  def register_command(command_class)
    CommandManager.instance.register_command(command_class)
  end
end