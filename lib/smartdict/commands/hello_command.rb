class Smartdict::Commands::HelloCommand < Smartdict::Command
  # arguments and their default values
  arguments :name
  default   :name => "world"

  # options and their default values.
  options :greating => "Hello",
          :today => lambda { Time.now.strftime("%A") }

  # Other helpful information about the command
  name        "hello"
  summary     "Summary for the hello command"
  description "Demonstrates how Command class works"
  syntax      "#{prog_name} NAME [--greating GREATING] [--today DAY]"
  usage <<-USAGE
    #{prog_name}         
    #{prog_name} Sergey
    #{prog_name} --today Friday
  USAGE

  # This method runs when command executes.
  def execute
    puts "#{@options[:greating]} #{@arguments[:name]}! Today is #{@options[:today]}."
  end
end

# == Output:
# smartdict hello
# Hello world! Today is Monday.
#
# smartdict hello Sergey
# Hello Sergey! Today is Monday.
# 
# smartdict hello Sergey --today Friday
# Hello Sergey! Today is Friday.
