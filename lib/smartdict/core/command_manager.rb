class Smartdict::Core::CommandManager
  include Smartdict::Core::IsManager
  include Smartdict::Commands

  register 'help'     , HelpCommand
  register 'version'  , VersionCommand
  register 'translate', TranslateCommand
  register 'list'     , ListCommand


  def self.run(args)
    first_arg = args.shift
    case first_arg
    when nil, '-h', '--help', 'help'
      run_command :help, args
    when nil, '-v', '--version', 'version'
      run_command :version, args
    else
      run_command(first_arg, args)
    end
  end

  def self.run_command(name, args = [])
    if command = find(name)
      command.run(args)
    else
      abort "Unknown command: #{name}"
    end
  end
end
