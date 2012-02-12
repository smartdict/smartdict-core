class Smartdict::Formats::TextColorFormat < Smartdict::Formats::AbstractFormat
  set_name "text-color"
  set_description "Displays translation with ASCII highlight"

  # param [Models::Translator] translation
  def format_translation(translation)
    result = "#{bold_green(translation.word.name)}"
    result << green(" [#{translation.transcription}]") if translation.transcription
    result << "\n"

    translation.each_word_class do |word_class, meanings|
      result << "  #{bold(word_class)}\n"
      meanings.each do |meaning|
        result << "    #{meaning}\n"
      end
    end

    result
  end


  private

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def bold_green(text)
    colorize(text, "1;32")
  end

  def bold(text)
    colorize(text, 1)
  end

  def green(text)
    colorize(text, 32)
  end
end
