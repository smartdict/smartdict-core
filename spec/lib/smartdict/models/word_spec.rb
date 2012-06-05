require 'spec_helper'

describe Smartdict::Models::Word do
  describe 'properties' do
    it { should have_property :id            }
    it { should have_property :name          }
    it { should have_property :language_id   }
  end

  describe 'associations' do
    it { should belong_to :language     }
    it { should have_many :translations }
  end

  describe 'validations' do
    it { should validate_presence_of :language_id }
    it { should validate_presence_of :name        }
  end
end
