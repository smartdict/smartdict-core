class Smartdict::Core::CommandManager
  include Singleton
  include Smartdict::Commands

  attr_reader :commands

  def initialize
    @commands = {}
    register_command HelpCommand
    register_command TranslateCommand
    register_command ListCommand
  end

  def register_command(command_class)
    name = command_class.name.to_s
    raise Smartdict::Error.new("Command #{name} is already registered") if find_command(name)
    @commands[name] = command_class
  end

  def run(args)
    first_arg = args.shift
    case first_arg
    when '-h', '--help', 'help'
      run_command :help, args
    else
      cmd_name = find_command(first_arg) ? first_arg : :help
      run_command cmd_name, args
    end
  end

  def run_command(name, args = [])
    find_command(name).run(args)
  end

  def find_command(name)
    @commands[name.to_s]
  end
end
