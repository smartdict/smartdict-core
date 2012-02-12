class Smartdict::Models::Translation
  include DataMapper::Resource
  include Smartdict::Models

  property :id, Serial
  property :word_id     , Integer  # , :key => true
  property :from_lang_id, Integer  # , :key => true
  property :to_lang_id  , Integer  # , :key => true

  belongs_to :word
  belongs_to :from_lang, 'Language'
  belongs_to :to_lang  , 'Language'
  has n, :translated_words

  # TODO: it's a hack. Remove.
  def initialize(*args)
    self.class.finalize
    self.word_class_id = 1
    super(*args)
  end


  def self.init_from_hash(hash)
    from_lang = Language.first(:code => hash[:from_lang])
    to_lang = Language.first(:code => hash[:to_lang])

    word = Word.first_or_create(:name => hash[:word], :language_id => from_lang.id)
    word.transcription = hash[:transcription] if word.transcription.blank?
    word.save!

    translation = self.create(:word => word, :from_lang => from_lang, :to_lang => to_lang)

    hash[:translated].each do |word_class_name, meanings|
      meanings.each do |meaning|
        w = Word.first_or_create(:name => meaning, :language => to_lang)
        word_class = WordClass.first(:name => word_class_name)
        TranslatedWord.create(:word => w, :word_class => word_class, :translation => translation)
      end
    end

    translation
  end

  def self.try_to_find(word, from_lang_code, to_lang_code)
    from_lang = Smartdict::Models::Language.first(:code => from_lang_code)
    to_lang   = Smartdict::Models::Language.first(:code => to_lang_code)

    word = Smartdict::Models::Word.first(:name => word, :language_id => from_lang.id)
    if word && tr = Smartdict::Models::Translation.first(:from_lang => from_lang, :to_lang => to_lang, :word => word)
      tr
    else
      nil
    end
  end


  def transcription
    word && word.transcription
  end

  def each_word_class(&block)
    collection = {}
    translated_words.each do |word|
      arr = collection[word.word_class.name] ||= []
      arr << word.word.name
    end
    collection.each(&block)
  end
end
