class Smartdict::Models::Translation
  include DataMapper::Resource
  include Smartdict::Models

  property :id          , Serial
  property :word_id     , Integer  #, :key => true
  property :from_lang_id, Integer  #, :key => true
  property :to_lang_id  , Integer  #, :key => true
  property :driver_id   , Integer  #, :key => true

  belongs_to :word
  belongs_to :driver
  belongs_to :from_lang, 'Language'
  belongs_to :to_lang  , 'Language'
  has n, :translated_words
  has n, :translation_queries

  validates_presence_of :word
  validates_presence_of :driver
  validates_presence_of :from_lang_id
  validates_presence_of :to_lang_id


  # Create {Translation} from hash returned by {Smartdict::Driver#translate}.
  def self.create_from_hash(hash)
    from_lang = Language.first(:code => hash[:from_lang])
    to_lang   = Language.first(:code => hash[:to_lang])
    driver    = Driver.first(:name => hash[:driver])

    word = Word.first_or_create(:name => hash[:word], :language_id => from_lang.id)
    word.transcription = hash[:transcription] if word.transcription.blank?
    word.save!

    translation = self.create(
      :word      => word,
      :driver    => driver,
      :from_lang => from_lang,
      :to_lang   => to_lang
    )

    hash[:translated].each do |word_class_name, meanings|
      meanings.each do |meaning|
        w = Word.first_or_create(:name => meaning, :language => to_lang)
        word_class = WordClass.first(:name => word_class_name)
        TranslatedWord.create(:word => w, :word_class => word_class, :translation => translation)
      end
    end

    translation
  end

  def self.find(word, from_lang_code, to_lang_code)
    from_lang = Language.first(:code => from_lang_code)
    to_lang   = Language.first(:code => to_lang_code)
    word = Word.first(:name => word, :language_id => from_lang.id)
    self.first(:from_lang => from_lang, :to_lang => to_lang, :word => word)
  end


  # TODO: it's a hack. Remove.
  def initialize(*args)
    self.class.finalize
    self.word_class_id = 1
    super(*args)
  end

  def transcription
    word.try(:transcription)
  end

  def each_word_class(&block)
    grouped = translated_words.group_by{ |w| w.word_class.name }
    grouped.each{ |word_class, twords| twords.map!{|w| w.word.name}}
    grouped.each(&block)
  end
end
