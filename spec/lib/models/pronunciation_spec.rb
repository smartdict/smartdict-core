require 'spec_helper'

describe Smartdict::Models::Pronunciation do
  
  describe 'properties' do
    specify {Smartdict::Models::Pronunciation.should have_property :word_id}
    specify {Smartdict::Models::Pronunciation.should have_property :translation_source_id}
    specify {Smartdict::Models::Pronunciation.should have_property :filename}
  end

  describe 'associations' do
    specify { Smartdict::Models::Pronunciation.should belong_to :word}
    specify { Smartdict::Models::Pronunciation.should belong_to :translation_source}
  end


  describe 'methods' do
    before(:each) do
      @w = Smartdict::Models::Word.gen :name     => "long live rock'n'roll",
			       :language => Smartdict::Models::Language.first(:code => 'en')
      @ts = Smartdict::Models::TranslationSource.first(:name => 'google')
      @pron = Smartdict::Models::Pronunciation.new(:word => @w,
					  :translation_source => @ts,
					  :bin_data_ext => 'mp3',
					  :bin_data     => 'binary')
    end

  end
end
