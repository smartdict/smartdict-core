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


    describe 'gen_filename' do
      it 'generates name for file based on word and translation source' do
	@pron.send(:gen_filename).should == 'google__long_live_rock_n_roll.mp3'
      end
    end

    describe 'filepath' do
      it 'returns absolute path to file' do
	expected = "#{Smartdict.pronunciations_dir}/#{@w.language.code}/google__long_live_rock_n_roll.mp3"
	@pron.filepath.should == expected
      end
    end

    describe 'before save' do
      after(:all) do
	FileUtils.rm_rf @pron.filepath	
      end

      it 'should create file with bin_data' do
	@pron.save
	FileTest.exists?(@pron.filepath).should == true
	File.read(@pron.filepath).should == "binary"
      end
    end

  end
end
