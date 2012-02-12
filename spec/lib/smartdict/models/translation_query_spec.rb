require 'spec_helper'

describe Smartdict::Models::TranslationQuery do
  describe 'properties' do
    it { should have_property :id }
    it { should have_property :created_at }
    it { should have_property :translation_id }
  end

  describe 'associations' do
    it { should belong_to :translation }
  end

  it 'fills created_at before save' do
    query = Smartdict::Models::TranslationQuery.make(:created_at => nil)
    query.save
    query.created_at.should_not be_blank
  end

end
