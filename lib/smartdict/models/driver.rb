class Smartdict::Models::Driver
  include DataMapper::Resource
  include DataMapper::Validations
  include DataMapper::Enum

  acts_as_enumerated

  property :id  , Serial
  property :name, String

  has n, :translations

  validates_presence_of :name
end
