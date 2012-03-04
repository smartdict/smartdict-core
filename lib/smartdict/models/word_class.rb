# Word class is the same what type of speech is (noun, verb, etc.)
class Smartdict::Models::WordClass
  include DataMapper::Resource
  include DataMapper::Enum

  acts_as_enumerated

  property :id,   Serial
  property :name, String

  has n, :translations

  validates_presence_of :name
end
