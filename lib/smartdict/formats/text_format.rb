class Smartdict::Formats::TextFormat < Smartdict::Formats::AbstractFormat
  set_name "text"
  set_description "Displays translation in pure text"


  def format_translation(translation)
    result = "#{translation.word.name}"
    result << " [#{translation.transcription}]" if translation.transcription
    result << "\n"

    translation.each_word_class do |word_class, meanings|
      result << "  #{word_class}\n"
      meanings.each do |meaning|
        result << "    #{meaning}\n"
      end
    end

    result
  end

end
