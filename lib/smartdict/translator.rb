class Smartdict::Translator
  include Smartdict::Models

  cattr_accessor :driver_name
  @@driver_name = :google_translator

  cattr_accessor :from_lang_code
  @@from_lang_code = :en

  cattr_accessor :to_lang_code
  @@to_lang_code = :ru


  def self.translate(word)
    unless translation = Translation.try_to_find(word, from_lang_code, to_lang_code)
      hash = driver.translate(word, from_lang_code, to_lang_code)
      translation = Translation.init_from_hash(hash)
      translation.save
    end
    translation
  end



  private

  def self.driver
    Smartdict::Core::DriverManager.instance.find_driver(@@driver_name)
  end
end
