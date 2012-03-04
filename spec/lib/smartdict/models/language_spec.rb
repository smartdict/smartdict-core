require 'spec_helper'

describe Smartdict::Models::Language do
  describe 'properties' do
    it { should have_property :id   }
    it { should have_property :name }
    it { should have_property :code }
  end

  describe 'associations' do
    it { should have_many :words }
  end

  describe "validations" do
    it { should validate_presence_of :name   }
    it { should validate_presence_of :code   }
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :code }
  end
end
