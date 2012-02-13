require 'spec_helper'

describe Smartdict::Models::Driver do

  describe 'properties' do
    it { should have_property :id   }
    it { should have_property :name }
  end

  describe 'associations' do
    # TODO: fix dm-rspec bug and refactor it to
    # it { should have_many :translations }
    specify { Smartdict::Models::Driver.should have_many :translations }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end
end
