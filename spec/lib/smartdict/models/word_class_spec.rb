require 'spec_helper'

describe Smartdict::Models::WordClass do
  describe 'properties' do
    it { should have_property :id   }
    it { should have_property :name }
  end

  describe 'associations' do
    it { should have_many :translations }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end
end
