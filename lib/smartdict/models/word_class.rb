# Word class is the same what is type of speech and lexical class
class Smartdict::Models::WordClass
  include DataMapper::Resource
  include DataMapper::Enum

  acts_as_enumerated

  property :id,   Serial
  property :name, String, :required => true

  has n, :translations
end
