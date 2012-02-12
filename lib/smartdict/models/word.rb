class Smartdict::Models::Word
  include DataMapper::Resource

  property :id           , Serial
  property :name         , String , :required => true
  property :transcription, String
  property :language_id  , Integer

  belongs_to :language, :required  => true
  has n, :translations

  validates_presence_of :language_id
end
