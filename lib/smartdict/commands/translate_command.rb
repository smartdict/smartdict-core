module Smartdict::Commands
  class TranslateCommand < AbstractCommand
    include HasFormatList

    set_name        "translate"
    set_summary     "Translate a word"
    set_description "Translate a word"
    set_syntax       "#{prog_name} <WORD> [--from LANGUAGE] [--to LANGUAGE] [--format FORMAT]"
    set_usage <<-USAGE
      #{prog_name} hello
      #{prog_name} again --from en --to ru
      #{prog_name} again --format text
    USAGE

    arguments :word

    options :from   => lambda { configatron.default.from_lang },
            :to     => lambda { configatron.default.to_lang },
            :format => lambda { configatron.default.format },
            :driver => nil

    def execute
      translator_opts = {
        :from_lang => @options[:from],
        :to_lang   => @options[:to],
        :log       => true
      }
      translator_opts[:driver] = @options[:driver] if @options[:driver]

      translator = Smartdict::Translator.new(translator_opts)
      translation = translator.translate(@arguments[:word])
      puts format.format_translation(translation)
    end

    def format
      format = Smartdict::FormatManager.find(@options[:format])
      raise Smartdict::Error.new("Wrong format: #{@options[:format]}") unless format
      format
    end

  end
end
