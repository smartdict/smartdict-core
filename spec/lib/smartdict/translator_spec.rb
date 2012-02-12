require 'spec_helper'

describe Smartdict::Translator do
  describe ".trasnalte" do
    context "when translation doesn't exist in storage" do
      before :all do
        stub_request(:get, "http://translate.google.com/translate_a/t?client=t&hl=en&multires=1&otf=1&rom=1&sc=1&sl=en&ssel=0&text=today&tl=ru&tsel=0").
          to_return(:body => %Q{[[["сегодня","today","segodnya",""]],[["noun",["segodnya","nashi dni"]],["adverb",["v nashi dni"]]],"en",,[["сегодня",[5],1,0,1000,0,1,0]],[["today",4,,,""],["today",5,[["сегодня",1000,1,0],["сегодняшнее",0,1,0],["сегодняшней",0,1,0],["сегодняшнем",0,1,0],["сегодняшнего",0,1,0]],[[0,5]],"today"]],,,[["en"]],85]})
        @translation = Smartdict::Translator.translate("today")
      end

      describe "returned translation" do
        subject { @translation }

        its(:from_lang) { should == "en" }
        its(:to_lang  ) { should == "ru" }
        its(:word     ) { should == "today" }

        describe "translated" do
          describe "noun" do
            subject { @translation.translated["noun"] }
            it { should include "segodnya" }
            it { should include "nashi dni" }
          end

          describe "adverb" do
            subject { @translation.translated["adverb"] }
            it { should include "v nashi dni" }
          end
        end

      end

      describe "translation from storage" do
        before :all do
          en = Smartdict::Models::Language.first(:code => "en")
          ru = Smartdict::Models::Language.first(:code => "ru")
          verb = Smartdict::Models::WordClass.first(:name => "verb")
          give = Smartdict::Models::Word.create!(:name => "give", :language => en)
          davat = Smartdict::Models::Word.create!(:name => "davat", :language => ru)
          day = Smartdict::Models::Word.create!(:name => "day", :language => ru)
          tr = Smartdict::Models::Translation.create!(:from_lang => en, :to_lang => ru, :word => give, :word_class_id => 1)
          Smartdict::Models::TranslatedWord.create!(:word_class => verb, :translation => tr, :word => davat)
          Smartdict::Models::TranslatedWord.create!(:word_class => verb, :translation => tr, :word => day)

          @translation = Smartdict::Translator.translate("give")
        end

        subject { @translation }

        its(:from_lang) { should == "en" }
        its(:to_lang  ) { should == "ru" }
        its(:word     ) { should == "give" }

        describe "translated" do
          describe "verb" do
            subject { @translation.translated["verb"] }
            it { should include "davat" }
            it { should include "day" }
          end
        end

      end
    end
  end
end
