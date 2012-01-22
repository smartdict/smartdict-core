require 'spec_helper'

describe Smartdict::Models::TranslationQuery do
  describe 'properties' do
    specify {Smartdict::Models::TranslationQuery.should have_property :id}
    specify {Smartdict::Models::TranslationQuery.should have_property :created_at}
    specify {Smartdict::Models::TranslationQuery.should have_property :word_id}
    specify {Smartdict::Models::TranslationQuery.should have_property :target_language_id}
  end

  describe 'associations' do
    specify { Smartdict::Models::TranslationQuery.should belong_to :target_language}
    specify { Smartdict::Models::TranslationQuery.should belong_to :word}
  end

  it 'fills created_at before save' do
    query = Smartdict::Models::TranslationQuery.make(:created_at => nil)
    query.save
    query.created_at.should_not be_blank
  end

end
