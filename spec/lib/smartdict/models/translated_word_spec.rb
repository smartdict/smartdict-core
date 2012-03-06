require 'spec_helper'

describe Smartdict::Models::TranslatedWord do
  describe "properties" do
    it { should have_property :id             }
    it { should have_property :translation_id }
    it { should have_property :word_class_id  }
    it { should have_property :word_id        }
  end

  describe "associations" do
    it { should belong_to :translation }
    it { should belong_to :word_class  }
    it { should belong_to :word        }
  end

  describe "validations" do
    it { should validate_presence_of :translation_id }
    it { should validate_presence_of :word_class_id  }
    it { should validate_presence_of :word_id        }
  end
end
