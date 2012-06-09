module Smartdict::Commands
  # Displays information about the program.
  # It's executed when user runs one of:
  # * smartdict -v
  # * smartdict --version
  # * smartdict version
  class VersionCommand < AbstractCommand
    include Smartdict::Core

    set_name        "version"
    set_summary     "Displays information about Smartdict"
    set_description "Displays information about Smartdict"
    set_syntax       prog_name

    set_usage <<-SYNTAX
      smartdict --version
      smartdict -v
      #{prog_name}
    SYNTAX

    # :nodoc:
    def execute
      msg = "\n" \
      "Smartdict #{Smartdict::VERSION}\n" \
      "Author: Sergey Potapov (blake131313 at gmail)\n" \
      "URL: http://smartdict.net\n\n"
      puts msg
    end
  end
end
