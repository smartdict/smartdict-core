class Smartdict::Models::Driver
  include DataMapper::Resource
  include DataMapper::Validations

  property :id  , Serial
  property :name, String

  has n, :translations

  validates_presence_of :name
end
