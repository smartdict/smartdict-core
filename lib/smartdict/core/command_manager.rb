require 'singleton'

class Smartdict::Core::CommandManager
  include Singleton 

  def initialize
    @commands = {}
    register_command :help, Smartdict::Commands::HelpCommand
  end

  def register_command(name, klass)
    @commands[name.to_s] = klass
  end

  def run(args)
    case args[0]
    when '-h', '--help', 'help'
      run_command(:help)
    end
  end

  def run_command(name, args = {})
    @commands[name.to_s].run(args)
  end
end
