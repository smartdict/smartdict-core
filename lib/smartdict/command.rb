# Basic class for all command classes.
#
# == Usage:
#   class Smartdict::Commands::HelloCommand < Smartdict::Command
#     # arguments and their default values
#     arguments :name
#     default   :name => "world"
#   
#     # options and their default values.
#     options :greating => "Hello",
#             :today => lambda { Time.now.strftime("%A") }
#   
#     # Other helpful information about the command
#     name        "hello"
#     summary     "Summary for the hello command"
#     description "Demonstrates how Command class works"
#     syntax      "#{prog_name} NAME [--greating GREATING] [--today DAY]"
#     usage <<-USAGE
#       #{prog_name}         
#       #{prog_name} Sergey
#       #{prog_name} --today Friday
#     USAGE
#   
#     # This method runs when command executes.
#     def execute
#       puts "#{@options[:greating]} #{@arguments[:name]}! Today is #{@options[:today]}."
#     end
#   end
#   
#   # == Output:
#   # smartdict hello
#   # Hello world! Today is Monday.
#   #
#   # smartdict hello Sergey
#   # Hello Sergey! Today is Monday.
#   # 
#   # smartdict hello Sergey --today Friday
#   # Hello Sergey! Today is Friday.
class Smartdict::Command
  # Number of spaces for indent.
  INDENT_SIZE = 2

  # array with available arguments
  class_attribute :known_arguments

  # hash with default values for {known_arguments}.
  class_attribute :default_argument_values

  # hash with names of options and default values
  class_attribute :known_options

  # short summary message for a command
  class_attribute :summary_message

  # command description
  class_attribute :description_message

  # command name
  class_attribute :command_name

  # multi line text with syntax format
  class_attribute :syntax_message

  # multi line text with usage example
  class_attribute :usage_message

  # Runs command.
  # @param [Array] args arguments passed from the command line
  def self.run(args)
    self.new(args).execute
  end

  # Defines available arguments and their order. 
  def self.arguments(*argument_names)
    self.known_arguments = argument_names
  end

  # Sets default values for arguments.
  # @param [Hash] values
  def self.default(values)
    self.default_argument_values = values
  end

  # Defines available options with their default values.
  # == Usage:
  #   options :to => "en",
  #           :from => lambda { Settings.current_language }
  def self.options(options = {})
    raise Smartdict::Error.new("options must be a hash") unless options.is_a? Hash
    self.known_options = options
  end

  # Sets summary message for a command.
  def self.summary(summary)
    self.summary_message = summary
  end

  # Sets description message for a command.
  def self.description(description)
    self.description_message = description
  end

  # Defines name of a command.
  def self.name(name)
    self.command_name = name
  end

  # Sets syntax message.
  # @param [String] syntax multi line text with number of syntax examples
  def self.syntax(syntax)
    self.syntax_message = syntax
  end

  # Sets usage examples
  # @param [String] usage multi line text with number of usage examples.
  def self.usage(usage)
    self.usage_message = usage
  end

  # @return [String] program name. It's meant to be used in usage examples.
  def self.prog_name
    "smartdict #{command_name}"
  end

  # @return [String] help message for the command to be displayed.
  def self.help_message
    message = "#{description_message}\n\n" 
    message << "#{help_syntax_message}\n" 
    message << "#{help_usage_message}\n"
  end

  # @return [String] syntax part of the help message.
  def self.help_syntax_message
    result = " " * INDENT_SIZE + "Syntax:\n"
    syntax_message.split("\n").map do |line|
      result << " " * INDENT_SIZE * 2 + "#{line.strip}\n"
    end
    result
  end

  # @return [String] usage part of the help message.
  def self.help_usage_message
    result = " " * INDENT_SIZE + "Usage:\n"
    usage_message.split("\n").map do |line|
      result << " " * INDENT_SIZE * 2 + "#{line.strip}\n"
    end
    result
  end

  # Sets default values for class attributes.
  def self.inherited(base)
    base.known_arguments ||= []
    base.known_options ||= {}
  end



  # @param [Array] args arguments passed from the command line
  def initialize(args)
    set_arguments_and_options!(args)
  end

  # Parses all passed arguments and initializes @arguments and @options variables.
  # @param [Array] args arguments passed from the command line
  def set_arguments_and_options!(args)
    arguments, options = extract_arguments_and_options(args)
    set_arguments!(arguments)
    set_options!(options)
  end

  # Splits input args to arguments and options.
  # Returns arguments as an array and options as a hash.
  def extract_arguments_and_options(args)
    arguments = []
    options = {}
    args = args.dup
    while value = args.shift
      if match = value.match(/^--(\w+)/)
        options[match[1].to_sym] = args.shift
      else
        arguments << value
      end
    end
    [arguments, options]
  end

  # Initializes @arguments variable.
  # If no argument was passed then it uses default value.
  def set_arguments!(arg_values)
    @arguments = {}
    known_arguments.each_with_index do |arg_name, index|
      if value = arg_values[index]
        @arguments[arg_name.to_sym] = value
      elsif default_argument_values.has_key?(arg_name.to_sym)
        @arguments[arg_name.to_sym] = default_argument_values[arg_name.to_sym]
      else
        raise Smartdict::Error.new("Argument `#{arg_name}` is not passed")
      end
    end
  end

  # Initializes @options variable.
  # If no argument was passed then it uses default value.
  def set_options!(options)
    @options = {}
    known_options.each do |opt_name, default_value|
      value = options[opt_name]
      unless value
        value = case default_value
          when Proc then default_value.call
          else default_value
        end
      end
      @options[opt_name] = value
    end
  end

end
