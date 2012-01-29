class Smartdict::Driver
  attr_reader :word, :from_lang, :to_lang

  def self.translate(*args)
    self.new(*args).translate
  end

  def initialize(word, from_lang, to_lang)
    @word      = word
    @from_lang = from_lang
    @to_lang   = to_lang
  end

  def translate
    { :word        => word,
      :from_lang   => from_lang,
      :to_lang     => to_lang,
      :translation => translation }
  end
end