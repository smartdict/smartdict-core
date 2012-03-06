class Smartdict::Models::TranslatedWord
  include DataMapper::Resource

  property :id, Serial
  property :translation_id, Integer, :unique_index => :index_translated_word
  property :word_class_id , Integer, :unique_index => :index_translated_word
  property :word_id       , Integer, :unique_index => :index_translated_word

  belongs_to :translation
  belongs_to :word_class
  belongs_to :word

  validates_presence_of :translation_id, :word_class_id, :word_id
end
