require 'spec_helper'

describe Smartdict::Core::FormatManager do
  describe '.[]' do
    it 'returns instance of format class' do
      described_class["text"].should == Smartdict::Formats::TextFormat
      described_class[:text].should == Smartdict::Formats::TextFormat
    end
  end

  describe '.register' do
    it 'registers new format' do
      paper_book_format = stub(:paper_book_format)
      described_class.register "paper_book", paper_book_format
      described_class["paper_book"].should == paper_book_format
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
      it("#{name}") { described_class[name].should == klass }
    end
  end
end
