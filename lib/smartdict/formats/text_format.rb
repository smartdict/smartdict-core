class Smartdict::Formats::TextFormat < Smartdict::Formats::TextColorFormat
  set_name "text"
  set_description "Displays translation in pure text"

  private

  def colorize(text, color_code)
    text
  end
end
