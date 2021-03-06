require 'spec_helper'

describe Smartdict::Core::FormatManager do
  describe '.find' do
    it 'returns instance of format class' do
      described_class.find("text").should == Smartdict::Formats::TextFormat
      described_class.find(:text).should == Smartdict::Formats::TextFormat
    end
  end

  describe '.register' do
    it 'registers new format' do
      paper_book_format = stub(:paper_book_format)
      described_class.register "paper_book", paper_book_format
      described_class.find("paper_book").should == paper_book_format
    end

    it "raises error when format already is registered" do
      wall = stub(:wall)
      described_class.register('wall', wall)
      expect { described_class.register('wall', wall) }.
        to raise_error(Smartdict::Error, "`wall` is already registered")
    end
  end

  describe '.all' do
    it "return hash of formats" do
      all = described_class.all
      all.should be_a Hash
      all["text"].should == Smartdict::Formats::TextFormat
    end
  end

  describe 'default formats' do
    formats = {
      "text"       => Smartdict::Formats::TextFormat,
      "text_color" => Smartdict::Formats::TextColorFormat,
      "fb2"        => Smartdict::Formats::Fb2Format
    }
    formats.each do |name, klass|
      it("#{name}") { described_class.find(name).should == klass }
    end
  end
end
