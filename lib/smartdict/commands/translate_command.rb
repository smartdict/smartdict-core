class Smartdict::Commands::TranslateCommand < Smartdict::Command
  name        "translate"
  summary     "Translate a word"
  description "Translate a word"
  syntax       "#{prog_name} <WORD> [--from LANGUAGE] [--to LANGUAGE]"
  usage <<-USAGE
    #{prog_name} hello
    #{prog_name} again --from en
    #{prog_name} again --to ru
  USAGE

  arguments :word

  options :from => "en",
          :to   => "ru"

  def execute
    Smartdict::Translator.from_lang_code = @options[:from]
    Smartdict::Translator.to_lang_code   = @options[:to]

    translation = nil
    translation = Smartdict::Translator.translate(@arguments[:word])

    puts view(translation)
  end

  def view(translation)
    tr = translation
    result = ""

    result << "#{word_color tr.word.name}"
    result << transcription_color(" [#{tr.transcription}]") if tr.transcription
    result << "\n"

    tr.each_word_class do |word_class, meanings|
      result << "  #{word_class_color word_class}\n"
      meanings.each do |meaning|
        result << "    #{meaning}\n"
      end
    end

    result
  end


  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def word_color(text); colorize(text, "1;32"); end
  def word_class_color(text); colorize(text, 1); end
  def transcription_color(text); colorize(text, 32); end

end
