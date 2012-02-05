#class Smartdict::Models::Translation
#  include DataMapper::Resource

#  property :source_id            , Integer, :key => true, :min => 1
#  property :target_id            , Integer, :key => true, :min => 1
#  property :word_class_id        , Integer, :key => true, :min => 1
#  property :translation_source_id, Integer, :key => true, :min => 1

#  belongs_to :source,        'Word', :key =>  true
#  belongs_to :target,        'Word', :key =>  true
#  belongs_to :word_class,            :key =>  true
#  belongs_to :translation_source,    :key =>  true
#end


class Smartdict::Models::Translation
  include DataMapper::Resource

  property :word_id     , Integer, :key => true
  property :from_lang_id, Integer, :key => true
  property :to_lang_id  , Integer, :key => true

  belongs_to :word
  belongs_to :from_lang, 'Language'
  belongs_to :to_lang  , 'Language'
end



class Smartdict::Models::TranslatedWord
  include DataMapper::Resource

  property :translation_id, Integer, :key => true
  property :word_class_id , Integer, :key => true
  property :word_id       , Integer, :key => true

  belongs_to :translation
  belongs_to :word_class
  belongs_to :word
end
