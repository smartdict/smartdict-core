class Smartdict::Translation
  attr_accessor :word,
                :transcription,
                :from_lang,
                :to_lang,
                :driver,
                :translated

  def initialize(attrs)
    @translated = {}
    attrs.each do |attr, value|
      self.send("#{attr}=", value)
    end
  end

  def [](word_class)
    @translated[word_class.to_s] ||= []
  end
end
