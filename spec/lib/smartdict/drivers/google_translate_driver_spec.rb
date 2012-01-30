require 'spec_helper'

describe Smartdict::Drivers::GoogleTranslateDriver do

  let(:hello_response) do
    <<-STR
      [[["привет","hello","privet",""]],[["",["Алло","Здравствуйте."]],["noun",["приветствие","приветственный возглас","возглас удивления"]],["verb",["здороваться","звать","окликать"]],["interjection",["привет","здравствуйте","алло"]]],"en",,[["привет",[5],1,0,1000,0,1,0]],[["hello",4,,,""],["hello",5,[["привет",1000,1,0],["Привета",0,1,0],["Приветом",0,1,0],["Привету",0,1,0],["Привете",0,1,0]],[[0,5]],"hello"]],,,[["en"]],4]
    STR
  end


  describe ".translate" do
    describe "returned translation" do
      before :all do
        stub_request(:get, "http://translate.google.com/translate_a/t?client=t&hl=en&multires=1&otf=1&rom=1&sc=1&sl=en&ssel=0&text=hello&tl=ru&tsel=0").
          to_return(:body => hello_response)
        @result = Smartdict::Drivers::GoogleTranslateDriver.translate "hello", "en", "ru"
      end

      subject { @result }

      it { should include_hash :word      => "hello" }
      it { should include_hash :from_lang => "en" }
      it { should include_hash :to_lang   => "ru" }
      it { should have_key :translation }

      describe "translation" do
        let (:translation) { @result[:translation] }

        it "undefined" do
          translation['undefined'].should == ["Алло", "Здравствуйте."]
        end

        it "noun" do
          translation['noun'].should == ["приветствие", "приветственный возглас", "возглас удивления"]
        end

        it "verb" do
          translation['verb'].should == ["здороваться", "звать", "окликать"]
        end

        it "interjection" do
          translation['interjection'].should == ["привет", "здравствуйте", "алло"]
        end
      end

    end
  end
end