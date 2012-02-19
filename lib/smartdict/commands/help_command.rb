module Smartdict::Commands
  class HelpCommand < AbstractCommand
    arguments :command
    default   :command => nil

    set_name        "help"
    set_summary     "Show help message"
    set_description "Smartdict is a dictionary designed to improve you knowledge of foreign languages."
    set_syntax <<-SYNTAX
      smartdict COMMAND [arguments...] [options...]
      #{prog_name} COMMAND
      smartdict --help
      smartdict --version
    SYNTAX

    set_usage <<-SYNTAX
      #{prog_name} translate
      #{prog_name} list
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
      message = "#{description}\n\n"
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
        result << "    #{command_class.summary}\n"
      end
      result
    end

  end
end
