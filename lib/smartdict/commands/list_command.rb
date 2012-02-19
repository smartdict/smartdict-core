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

    options :format => lambda { configatron.common.format },
            :since  => lambda { Date.today },
            :till   => lambda { Time.now },
            :from   => nil,
            :to     => nil

    def execute
      query = Translation.all(
        Translation.translation_queries.created_at.gte => @options[:since],
        Translation.translation_queries.created_at.lte => @options[:till]
      )
      query = query.all(Translation.to_lang_id => to_lang.id) if to_lang
      query = query.all(Translation.from_lang_id => from_lang.id) if from_lang

      translations = query
      puts format.format_list(translations)
    end

    def format
      format = Smartdict::FormatManager.instance.find_format(@options[:format])
      raise Smartdict::Error.new("Wrong format: #{@options[:format]}") unless format
      format
    end

    def from_lang
      @from_lang ||= Language.first(:code => @options[:from])
    end

    def to_lang
      @to_lang ||= Language.first(:code => @options[:to])
    end

  end
end
