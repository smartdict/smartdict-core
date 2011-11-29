class Smartdict::Models::Translation
  include DataMapper::Resource

  property :source_id            , Integer, :key => true, :min => 1
  property :target_id            , Integer, :key => true, :min => 1
  property :word_class_id        , Integer, :key => true, :min => 1
  property :translation_source_id, Integer, :key => true, :min => 1

  belongs_to :source,        'Word', :key =>  true
  belongs_to :target,        'Word', :key =>  true
  belongs_to :word_class,            :key =>  true
  belongs_to :translation_source,    :key =>  true
end
