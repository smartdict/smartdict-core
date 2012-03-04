class Smartdict::Models::Word
  include DataMapper::Resource

  property :id           , Serial
  property :name         , String, :unique_index => :index_word
  property :language_id  , Integer, :unique_index => :index_word
  property :transcription, String

  belongs_to :language
  has n, :translations

  validates_presence_of :language_id, :name
end
