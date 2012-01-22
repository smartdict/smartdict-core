require 'singleton'

class Smartdict::Core::CommandManager
  include Singleton 

  attr_reader :commands

  def initialize
    @commands = {}
    register_command :help     , Smartdict::Commands::HelpCommand
    register_command :translate, Smartdict::Commands::TranslateCommand
  end

  def register_command(name, klass)
    @commands[name.to_s] = klass
  end

  def run(args)
    cmd_name = args.shift
    case cmd_name 
    when '-h', '--help', 'help'
      run_command :help, args
    end
  end

  def run_command(name, args)
    @commands[name.to_s].run(args)
  end
end
