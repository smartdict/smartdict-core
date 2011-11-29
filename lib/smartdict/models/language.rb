class Smartdict::Models::Language
  include DataMapper::Resource
  include DataMapper::Validations

  property :id  , Serial
  property :name, String
  property :code, String #, :length => 2

  has n, :words

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :name, :code
end
