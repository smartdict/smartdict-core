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
      info = Smartdict.info
      puts "Smartdict core v#{info.version}\n" \
           "Author: #{info.author} (#{info.email})\n" \
           "URL: #{info.url}"
    end
  end
end
