class Smartdict::Models::Translation
  include DataMapper::Resource
  include Smartdict::Models

  property :id          , Serial
  property :word_id     , Integer, :unique_index => :index_translation
  property :from_lang_id, Integer, :unique_index => :index_translation
  property :to_lang_id  , Integer, :unique_index => :index_translation
  property :driver_id   , Integer, :unique_index => :index_translation

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


  # Create {Smartdict::Models::Translation} from {Smartdict::Translation}.
  def self.create_from_struct(struct)
    from_lang = Language[struct.from_lang]
    to_lang   = Language[struct.to_lang]
    driver    = Driver[struct.driver]

    word = Word.first_or_create(:name => struct.word, :language_id => from_lang.id)
    word.transcription = struct.transcription if word.transcription.blank?
    word.save!

    translation = self.create(
      :word      => word,
      :driver    => driver,
      :from_lang_id => from_lang.id,
      :to_lang_id   => to_lang.id
    )

    struct.translated.each do |word_class_name, meanings|
      meanings.each do |meaning|
        w = Word.first_or_create(:name => meaning, :language_id => to_lang.id)
        word_class = WordClass[word_class_name]
        TranslatedWord.create(:word => w, :word_class => word_class, :translation => translation)
      end
    end

    translation
  end

  def self.find(word, from_lang_code, to_lang_code, driver_name)
    from_lang = Language[from_lang_code]
    to_lang   = Language[to_lang_code]
    driver    = Driver[driver_name]

    word = Word.first(:name => word, :language_id => from_lang.id)
    self.first(:from_lang => from_lang, :to_lang => to_lang, :word => word, :driver => driver)
  end


  # TODO: it's a hack. Remove.
  def initialize(*args)
    self.class.finalize
    self.word_class_id = 1
    super(*args)
  end

  def to_struct
    struct = Smartdict::Translation.new(
      :word          => word.name,
      :transcription => word.transcription,
      :from_lang     => from_lang.code,
      :to_lang       => to_lang.code,
      :driver        => driver.name
    )
    translated_words.each do |tw|
      struct[tw.word_class.name] << tw.word.name
    end
    struct
  end

end
