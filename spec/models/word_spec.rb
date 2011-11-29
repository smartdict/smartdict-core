require 'spec_helper'

describe Smartdict::Models::Word do

  describe 'properties' do
    specify {Smartdict::Models::Word.should have_property :id}
    specify {Smartdict::Models::Word.should have_property :name}
    specify {Smartdict::Models::Word.should have_property :transcription}
  end

  describe 'associations' do
    specify { Smartdict::Models::Word.should belong_to :language}
    specify { Smartdict::Models::Word.should have_many :translations}
  end


  describe 'validations' do

    describe 'valid model' do
      it 'is valid' do
	word = Smartdict::Models::Word.make
	Smartdict::Models::Word.make.should be_valid
      end

      it 'is savable' do
	Smartdict::Models::Word.make.save.should == true
      end
    end

    it 'requires language' do
      word = Smartdict::Models::Word.make(:language => nil)
      word.should have_errors_on(:language_id)
    end

  end
end
