require 'spec_helper'

describe Smartdict::Models::Translation do
  describe 'properties' do
    specify {Smartdict::Models::Translation.should have_property :source_id}
    specify {Smartdict::Models::Translation.should have_property :target_id}
    specify {Smartdict::Models::Translation.should have_property :word_class_id}
    specify {Smartdict::Models::Translation.should have_property :translation_source_id}

    specify {Smartdict::Models::Translation.should_not have_property :id }
  end

  describe 'associations' do
    specify { Smartdict::Models::Translation.should belong_to :source }
    specify { Smartdict::Models::Translation.should belong_to :target }
    specify { Smartdict::Models::Translation.should belong_to :word_class }
    specify { Smartdict::Models::Translation.should belong_to :translation_source }
  end


  describe 'validations' do
    it 'can not be duplicated with the same source, target, word class and translation_source' do
      t1 = Smartdict::Models::Translation.gen
      t2 = Smartdict::Models::Translation.make(:source             => t1.source,
				       :target             => t1.target,
				       :word_class         => t1.word_class,
				       :translation_source => t1.translation_source)
      lambda{t2.save}.should raise_error(DataObjects::IntegrityError)
    end

    describe 'valid model' do
      it 'is valid' do
	Smartdict::Models::Translation.make.should be_valid
      end

      it 'is savable' do
	Smartdict::Models::Translation.make.save.should == true
      end
    end
  end

end
