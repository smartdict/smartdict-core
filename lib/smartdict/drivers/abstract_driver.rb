# Translation driver provides an ability to translate words using external
# data sources. It can be data from local disk, database or remote services
# like Google Translate.
# Every driver must inherit {Smartdict::Driver} and have implementation of
# {#translate} method. This method should sets translated and transcription
# properties. For examples you can see #{Smartdict::Driver::GoogleTranslateDriver}.
#
# In your implementation of {#translate} you need to use methods:
# * word - returns a word what needs to be translated.
# * from_lang - code of source language("en", "ru", etc)
# * to_lang - code of target language("en, "ru, etc)
#
# Usage:
#   class HelloWorldDriver < Smartdict::Driver
#     # Set name of driver, so DriverManager can identify it.
#     name "hello_world"
#
#     # This trivial example will always return the same translation.
#     def translate
#       self.translated = {"noun" => ["hello", "hi"], "verb" => ["greet"]}
#       self.transcription = "he'leu"
#     end
#   end
class Smartdict::Drivers::AbstractDriver

  attr_reader :word, :from_lang, :to_lang
  attr_accessor :translated, :transcription

  # Is used to identify a driver
  cattr_accessor :name

  def self.translate(*args)
    self.new(*args).build_translation
  end

  # Sets driver name
  def self.set_name(name)
    self.name = name.to_s
  end

  def initialize(word, from_lang, to_lang)
    @word      = word
    @from_lang = from_lang
    @to_lang   = to_lang
    translate
  end

  def build_translation
    translation = Smartdict::Translation.new(
      :word          => word,
      :from_lang     => from_lang.to_s,
      :to_lang       => to_lang.to_s,
      :transcription => transcription,
      :driver        => self.name
    )
    translated.each do |word_class, words|
      translation.translated[word_class] = words
    end
    translation
  end

end
