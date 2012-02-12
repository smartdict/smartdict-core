require 'spec_helper'

describe Smartdict::Models::Translation do
  describe 'properties' do
    it { should     have_property :word_id      }
    it { should     have_property :from_lang_id }
    it { should     have_property :to_lang_id   }
  end

  describe 'associations' do
    it { should belong_to :word      }
    it { should belong_to :from_lang }
    it { should belong_to :to_lang   }
  end
end
