class Smartdict::Models::Word
  include DataMapper::Resource

  property :id,            Serial
  property :name,          String, :required => true
  property :transcription, String

  belongs_to :language, :required  => true
  has n, :translations
  has n, :pronunciations
end
