class Smartdict::Models::TranslationSource
  include DataMapper::Resource
  include DataMapper::Validations

  property :id  , Serial
  property :name, String

  has n, :translations
  has n, :pronunciations

  validates_presence_of :name
  validates_uniqueness_of :name
end
