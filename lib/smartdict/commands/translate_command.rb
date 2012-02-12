module Smartdict::Commands
  class TranslateCommand < AbstractCommand
    name        "translate"
    summary     "Translate a word"
    description "Translate a word"
    syntax       "#{prog_name} <WORD> [--from LANGUAGE] [--to LANGUAGE] [--format FORMAT]"
    usage <<-USAGE
      #{prog_name} hello
      #{prog_name} again --from en --to ru
      #{prog_name} again --format text
    USAGE

    arguments :word

    options :from => "en",
            :to   => "ru",
            :format => "text-color"

    def self.help_message
      super << formats_help_message
    end

    def self.formats_help_message
      formats = Smartdict::Core::FormatManager.instance.formats
      width = formats.values.map{|f| f.name.size}.max
      result = " " * INDENT_SIZE + "Formats:\n"
      formats.each do |name, format|
        result << " " * 2 * INDENT_SIZE
        result << format.name.ljust(width) + "    "
        result << "#{format.description}\n"
      end
      result
    end


    def execute
      Smartdict::Translator.from_lang_code = @options[:from]
      Smartdict::Translator.to_lang_code   = @options[:to]
      translation = Smartdict::Translator.translate(@arguments[:word])
      puts format.format_translation(translation)
    end

    def format
      format = Smartdict::FormatManager.instance.find_format(@options[:format])
      raise Smartdict::Error.new("Wrong format: #{@options[:format]}") unless format
      format
    end

  end
end
