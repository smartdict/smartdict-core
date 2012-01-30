class Smartdict::Driver

  attr_reader :word, :from_lang, :to_lang
  attr_accessor :translated, :transcription

  def self.translate(*args)
    self.new(*args).build_translation
  end

  def initialize(word, from_lang, to_lang)
    @word      = word
    @from_lang = from_lang
    @to_lang   = to_lang
    translate
  end

  def build_translation
    { :word        => word,
      :from_lang   => from_lang,
      :to_lang     => to_lang,
      :translated  => translated }
  end

end
