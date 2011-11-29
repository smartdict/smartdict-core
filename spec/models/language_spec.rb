require 'spec_helper'

describe Smartdict::Models::Language do

  describe 'properties' do
    specify {Smartdict::Models::Language.should have_property :id }
    specify {Smartdict::Models::Language.should have_property :name }
    specify {Smartdict::Models::Language.should have_property :code }
  end

  describe 'associations' do
    specify { Smartdict::Models::Language.should have_many :words }
  end


  describe "validations" do

    describe 'valid model' do
      it 'is valid' do
	Smartdict::Models::Language.make.should be_valid
      end

      it 'is savable' do
	Smartdict::Models::Language.make.save.should == true
      end
    end

    describe 'name' do
      it 'is not blank' do
	lang = Smartdict::Models::Language.make(:name => '')	
	lang.should_not be_valid
      end

      it 'is unique' do
	lang1 = Smartdict::Models::Language.gen(:name => "DuplicatedName")
	lang2 = Smartdict::Models::Language.make(:name => 'DuplicatedName')
	lang2.should have_errors_on(:name)
      end
    end

    describe 'code' do
      it 'is not blank' do
	lang = Smartdict::Models::Language.make(:code => '')	
	lang.should have_errors_on(:code)
      end

      it 'is unique' do
	lang1 = Smartdict::Models::Language.gen(:code => "duplicated_code")
	lang2 = Smartdict::Models::Language.make(:code => "duplicated_code")
	lang2.should have_errors_on(:code)
      end

    end
  end
end
