# Word class is the same what is type of speech and lexical class
class Smartdict::Models::WordClass
  include DataMapper::Resource

  property :id,   Serial
  property :name, String, :required => true

  has n, :translations
end
