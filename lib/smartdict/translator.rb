module Smartdict
  class Translator

    class_attribute :driver_name
    self.driver_name = :google_translate

    class_attribute :from_lang_code
    self.from_lang_code = :en

    class_attribute :to_lang_code
    self.to_lang_code = :ru

    class_attribute :log_queries
    self.log_queries = true


    def self.translate(word)
      unless translation_model = Models::Translation.find(word, from_lang_code, to_lang_code, driver_name)
        translation = driver.translate(word, from_lang_code, to_lang_code)
        translation_model = Models::Translation.create_from_struct(translation)
      end
      log_query(translation_model) if log_queries
      translation_model.to_struct
    end

    def self.log_query(translation)
      Models::TranslationQuery.create(:translation => translation)
    end


    private

    def self.driver
      Smartdict::Core::DriverManager.find(driver_name)
    end

  end
end
