Smartdict::Models::Word.fixture {{
  :name => /\w{10}/.gen,
  :language => Smartdict::Models::Language[:en]
}}

Smartdict::Models::WordClass.fixture {{
  :name => /\w{10}/.gen,
  #:translations => 5.of {
}}

Smartdict::Models::Translation.fixture {{
  :from_lang => Smartdict::Models::Language[:en],
  :to_lang   => Smartdict::Models::Language[:ru],
  :word      => Smartdict::Models::Word.gen,
  :driver    => Smartdict::Models::Driver.first
}}

Smartdict::Models::TranslationQuery.fixture {{
  :translation => Smartdict::Models::Translation.gen,
  :created_at  => Time.now
}}
