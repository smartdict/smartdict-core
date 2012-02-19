require 'spec_helper'

describe Smartdict::Models::Translation do
  describe "properties" do
    it { should     have_property :word_id      }
    it { should     have_property :from_lang_id }
    it { should     have_property :to_lang_id   }
    it { should     have_property :driver_id    }
  end

  describe "associations" do
    it { should belong_to :word      }
    it { should belong_to :from_lang }
    it { should belong_to :to_lang   }
    it { should belong_to :driver    }
    it { should have_many :translated_words }
    it { should have_many :translation_queries }
  end

  describe "validations" do
    it { should validate_presence_of :word         }
    it { should validate_presence_of :driver       }
    it { should validate_presence_of :from_lang_id }
    it { should validate_presence_of :to_lang_id   }
  end
end
