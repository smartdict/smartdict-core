Smartdict::Models::Language.fixture {{
  :name => 'lang_name_' + /\w{10}/.gen,
  :code => 'lang_code_' + /\w{10}/.gen,
}}

Smartdict::Models::Word.fixture {{
  :name => /\w{10}/.gen,
  :language => Smartdict::Models::Language.gen
}}

Smartdict::Models::WordClass.fixture {{
  :name => /\w{10}/.gen,
  #:translations => 5.of {
}}

#Smartdict::Models::TranslationSource.fixture {{
#  :name => /\w{10}/.gen,
#}}

Smartdict::Models::Translation.fixture {{
  :source             => Smartdict::Models::Word.gen,
  :target             => Smartdict::Models::Word.gen,
  :word_class         => Smartdict::Models::WordClass.gen,
  :translation_source => Smartdict::Models::TranslationSource.gen,
}}

Smartdict::Models::TranslationQuery.fixture {{
  :word            => Smartdict::Models::Word.gen,
  :target_language => Smartdict::Models::Language.gen,
  :created_at      => Time.now
}}
