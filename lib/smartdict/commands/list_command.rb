module Smartdict::Commands
  class ListCommand < AbstractCommand
    include HasFormatList
    include Smartdict::Models

    set_name        "list"
    set_summary     "Lists words you translated before"
    set_description "Lists words you translated before in selected format(text_color by default)."
    set_syntax <<-SYNTAX
      #{prog_name} [--since DATE] [--till DATE] [--format FORMAT] [--from LANG] [--to LANG]
    SYNTAX

    set_usage <<-SYNTAX
      #{prog_name}
      #{prog_name} --since 2012-02-14 --till 2012-02-21
      #{prog_name} --from de --to en --format text
    SYNTAX

    options :format => lambda { configatron.default.format },
            :since  => lambda { Date.today     },
            :till   => lambda { Date.today + 1 },
            :from   => nil,
            :to     => nil,
            :driver => nil

    def execute
      fetch_opts = {
        :since     => @options[:since],
        :till      => @options[:till],
        :from_lang => @options[:from],
        :to_lang   => @options[:to],
        :driver    => @options[:driver]
      }
      translations = Smartdict::Log.fetch(fetch_opts)
      puts format.format_list(translations)
    end

    def format
      format = Smartdict::FormatManager.find(@options[:format])
      raise Smartdict::Error.new("Wrong format: #{@options[:format]}") unless format
      format
    end

  end
end
