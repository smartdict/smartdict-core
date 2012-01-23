class Smartdict::Commands::HelpCommand < Smartdict::Command
  arguments :command
  default   :command => nil

  name        "help"
  summary     "Show help message"
  description "Smartdict is a dictionary designed to improve you knowledge of foreign languages."
  syntax <<-SYNTAX
    smartdict COMMAND [arguments...] [options...]
    #{prog_name} COMMAND
    smartdict --help
    smartdict --version
  SYNTAX

  def execute
    if cmd_name = @arguments[:command]
      if cmd_class = command_manager.find_command(cmd_name)
        puts cmd_class.help_message
      else
        abort "Uknown command: #{cmd_name}"
      end
    else
      puts help_message
    end
  end

  def help_message
    message = "#{description_message}\n\n"
    message << "#{self.class.help_syntax_message}\n"
    message << help_commands_message
  end

  def command_manager
    Smartdict::Core::CommandManager.instance
  end

  def help_commands_message
    width = command_manager.commands.keys.map(&:size).max
    result = " " * INDENT_SIZE + "Commands:\n"
    command_manager.commands.each do |command_name, command_class|
      result << " " * 2 * INDENT_SIZE + "#{command_name.ljust(width)}"
      result << "    #{command_class.summary_message}\n"
    end
    result
  end
end
