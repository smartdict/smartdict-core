class Smartdict::Models::TranslatedWord
  include DataMapper::Resource

  property :id, Serial
  property :translation_id, Integer  , :key => true
  property :word_class_id , Integer  , :key => true
  property :word_id       , Integer  , :key => true

  belongs_to :translation
  belongs_to :word_class
  belongs_to :word
end
