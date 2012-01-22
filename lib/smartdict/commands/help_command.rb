class Smartdict::Commands::HelpCommand < Smartdict::Command

  #arguments :subcommand => nil
  #options   :core

  def execute
    command_manager = Smartdict::Core::CommandManager.instance
    command_manager.commands.each do |command_name, command_class|
      puts command_name
    end
  end

  def usage

  end

  def description

  end
end
