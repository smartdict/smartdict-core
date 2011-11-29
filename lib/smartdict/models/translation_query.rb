class Smartdict::Models::TranslationQuery
  include DataMapper::Resource

  property :id                , Serial
  property :created_at        , DateTime
  property :word_id           , Integer
  property :target_language_id, Integer

  belongs_to :word                       , :key => true
  belongs_to :target_language, 'Language', :key => true

  before :save do
    self.created_at = Time.now
  end
end
