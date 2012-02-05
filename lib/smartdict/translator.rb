module Smartdict::Translator
  extend self
  include Smartdict::Models
  
  mattr_accessor :driver_name
  @@driver_name = :google_translator

  mattr_accessor :from_lang_code
  @@from_lang_code = :en

  mattr_accessor :to_lang_code
  @@to_lang_code = :ru


  def translate(word)
    unless translation = fetch_translation(word)
      translation = driver.translate(word, from_lang_code, to_lang_code)
      save(translation)
    end
    translation
  end



  private

  def driver
    Smartdict::Core::DriverManager.instance.find_driver(@@driver_name)
  end

  def save(tr)
    from_lang = Language.first(:code => tr[:from_lang])
    to_lang = Language.first(:code => tr[:to_lang])

    word = Word.first_or_new(:name => tr[:word], :language_id => from_lang.id)
    word.transcription = tr[:transcroption]
    word.save!

    translation = Translation.create!(:word => word, :from_lang => from_lang, :to_lang => to_lang)

    tr[:translated].each do |word_class_name, meanings|
      meanings.each do |meaning|
        w = Word.first_or_create(:name => meaning, :language => to_lang)
        word_class = WordClass.first(:name => word_class_name)
        TranslatedWord.create(:word => w, :word_class => word_class, :translation => translation)
      end
    end
  end

  def fetch_translation(word)
    from_lang = Language.first(:code => from_lang_code)
    to_lang = Language.first(:code => to_lang_code)

    word = Word.first_or_new(:name => word, :language_id => from_lang.id)
    if tr = Translation.first(:from_lang => from_lang, :to_lang => to_lang, :word => word)
      build_translation(tr)
    else
      nil
    end
  end

  def build_translation(tr_model)
    tr = { :word          => tr_model.word.name,
           :transcription => tr_model.word.transcription,
           :from_lang     => tr_model.from_lang.code,
           :to_lang       => tr_model.to_lang.code}
    tr_model.translated_words.each do |tr_word|
      arr = tr[:translated][tr_word.word_class.name] ||= []
      arr < tr_word.word.name
    end
    tr
  end
end
