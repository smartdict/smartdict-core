module HelloWorld
  class HelloCommand < Smartdict::Commands::AbstractCommand
    # arguments and their default values
    arguments :name
    default   :name => "world"

    # options and their default values.
    options :greating => "Hello",
            :today => lambda { Time.now.strftime("%A") }

    # Other helpful information about the command
    set_name        "hello"
    set_summary     "Summary for the hello command"
    set_description "Demonstrates how Command class works"
    set_syntax      "#{prog_name} NAME [--greating GREATING] [--today DAY]"
    set_usage <<-USAGE
      #{prog_name}
      #{prog_name} Sergey
      #{prog_name} --today Friday
    USAGE

    # This method runs when command executes.
    def execute
      puts "#{@options[:greating]} #{@arguments[:name]}! Today is #{@options[:today]}."
    end
  end
end
