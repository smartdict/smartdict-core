class Smartdict::Formats::TextColorFormat < Smartdict::Formats::AbstractFormat
  set_description "Displays translation with ASCII highlight"

  # :nodoc:
  def format_translation(translation)
    result = "#{bold_green(translation.word)}"
    result << green(" [#{translation.transcription}]") if translation.transcription
    result << "\n"

    translation.translated.each do |word_class, words|
      result << "  #{bold(word_class)}\n"
      words.each do |word|
        result << "    #{word}\n"
      end
    end

    result
  end

  # :nodoc:
  def format_list(translations)
    result = ""
    translations.each do |translation|
      translated_words = translation.translated.values.map{|words| words.first(3)}.flatten

      result << green(translation.word)
      result << " - "
      result << translated_words.join(", ")
      result << "\n"
    end
    result
  end


  private

  def bold_green(text)
    colorize(text, "1;32")
  end

  def bold(text)
    colorize(text, 1)
  end

  def green(text)
    colorize(text, 32)
  end

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end
end
