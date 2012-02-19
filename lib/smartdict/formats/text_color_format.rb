class Smartdict::Formats::TextColorFormat < Smartdict::Formats::AbstractFormat
  set_name "text_color"
  set_description "Displays translation with ASCII highlight"

  # :nodoc:
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

  # :nodoc:
  def format_list(translations)
    result = ""
    translations.each do |translation|
      grouped = translation.translated_words.group_by(&:word_class)
      translated_words = grouped.values.map{|arr| arr.first(3)}.flatten

      result << green(translation.word.name)
      result << " - "
      result << translated_words.map{|tw| tw.word.name}.join(", ")
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
