require 'singleton'

class Smartdict::Core::CommandManager
  include Singleton 

  attr_reader :commands

  def initialize
    @commands = {}
    register_command Smartdict::Commands::HelpCommand
    register_command Smartdict::Commands::HelloCommand
    register_command Smartdict::Commands::TranslateCommand
  end

  def register_command(klass)
    @commands[klass.command_name.to_s] = klass
  end

  def run(args)
    cmd_name = args.shift
    case cmd_name 
    when '-h', '--help', 'help'
      run_command :help, args
    else
      run_command cmd_name, args
    end
  end

  def run_command(name, args = [])
    @commands[name.to_s].run(args)
  end

  def find_command(name)
    @commands[name.to_s]
  end
end
