class Smartdict::Translator
  include Smartdict::Models

  class_attribute :driver_name
  self.driver_name = :google_translate

  class_attribute :from_lang_code
  self.from_lang_code = :en

  class_attribute :to_lang_code
  self.to_lang_code = :ru

  class_attribute :log_queries
  self.log_queries = true


  def self.translate(word)
    unless translation = Translation.find(word, from_lang_code, to_lang_code)
      hash = driver.translate(word, from_lang_code, to_lang_code)
      translation = Translation.create_from_hash(hash)
    end
    log_query(translation) if log_queries
    translation
  end

  def self.log_query(translation)
    TranslationQuery.create(:translation => translation)
  end


  private

  def self.driver
    Smartdict::Core::DriverManager.instance.find_driver(driver_name)
  end
end
