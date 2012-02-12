class Smartdict::Models::TranslationQuery
  include DataMapper::Resource

  property :id            , Serial
  property :created_at    , DateTime
  property :translation_id, Integer

  belongs_to :translation, :key => true

  before :save do
    self.created_at = Time.now
  end
end
