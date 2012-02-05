require 'spec_helper'

describe Smartdict::Models::WordClass do

  describe 'properties' do
    specify {Smartdict::Models::WordClass.should have_property :id }
    specify {Smartdict::Models::WordClass.should have_property :name }
  end

  describe 'associations' do
    specify { Smartdict::Models::WordClass.should have_many :translations }
  end

  describe 'validations' do
    describe 'valid model' do
      it 'is valid' do
	Smartdict::Models::WordClass.make.should be_valid
      end

      it 'is savable' do
	Smartdict::Models::WordClass.make.save.should == true
      end
    end

    describe 'name' do
      it 'can not be blank' do
	wc = Smartdict::Models::WordClass.make(:name => '')
	wc.should have(1).error_on(:name)
      end
    end
  end

end
