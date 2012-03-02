module Smartdict::Commands
  class ListCommand < AbstractCommand
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
            :since  => lambda { Date.today },
            :till   => lambda { Time.now },
            :from   => nil,
            :to     => nil

    def execute
      list_opts = {
        :since     => @options[:since],
        :till      => @options[:till],
        :from_lang => @options[:from],
        :to_lang   => @options[:to]
        #:driver => @options
      }
      translations = Smartdict::ListBuilder.build(list_opts)
      puts format.format_list(translations)
    end

    def format
      format = Smartdict::FormatManager.instance.find_format(@options[:format])
      raise Smartdict::Error.new("Wrong format: #{@options[:format]}") unless format
      format
    end

  end
end
