# encoding: utf-8

require 'spec_helper'

describe Smartdict::Drivers::LingvoYandexDriver do

  def test_data(word, from_lang, to_lang)
    dir = File.expand_path("../test_data/lingvo_yandex/", __FILE__)
    file = "#{from_lang}-#{to_lang}_#{word}.html"
    file_path = File.join(dir, file)
    File.read(file_path)
  end

  describe ".translate" do

    describe "word 'one'" do
      before :all do
        stub_request(:get, "http://lingvo.yandex.ru/one/%D1%81+%D0%B0%D0%BD%D0%B3%D0%BB%D0%B8%D0%B9%D1%81%D0%BA%D0%BE%D0%B3%D0%BE/").
          to_return(:body => test_data("one", :en, :ru))
        @result = Smartdict::Drivers::LingvoYandexDriver.translate("one", "en", "ru")
      end

      subject { @result }

      its(:word)          { should == "one" }
      its(:driver)        { should == "lingvo_yandex" }
      its(:from_lang)     { should == "en" }
      its(:to_lang)       { should == "ru" }
      its(:transcription) { should == "wʌn" }
      its(:translated)    { should_not be_empty }


      it { should translate_as(:numeral).with("один", "номер один", "первый") }
      it { should translate_as(:noun).with("единица", "один", "одиночка", "час", "однодолларовая купюра купюра достоинством один фунт стерлингов") }
      it { should translate_as(:pronoun).with("кто-то", "некий", "некто") }
      it { should translate_as(:adjective).with("единственный", "уникальный", "определённый", "единственный в своём роде", "одинаковый", "такой же", "какой-то", "некий", "неопределённый", "очень", "крайне") }
    end


    describe "word 'survive'" do
      before :all do
        stub_request(:get, "http://lingvo.yandex.ru/survive/%D1%81+%D0%B0%D0%BD%D0%B3%D0%BB%D0%B8%D0%B9%D1%81%D0%BA%D0%BE%D0%B3%D0%BE/").
          to_return(:body => test_data("survive", :en, :ru))
        @result = Smartdict::Drivers::LingvoYandexDriver.translate("survive", "en", "ru")
      end

      subject { @result }

      its(:word)          { should == "survive" }
      its(:driver)        { should == "lingvo_yandex" }
      its(:from_lang)     { should == "en" }
      its(:to_lang)       { should == "ru" }
      its(:transcription) { should == "sə'vaɪv" }
      its(:translated)    { should_not be_empty }

      it { should translate_as(:verb).with("пережить", "выдержать", "перенести", "продолжать существовать", "сохраняться") }
    end


    describe "word 'rant'" do
      before :all do
        stub_request(:get, "http://lingvo.yandex.ru/rant/%D1%81+%D0%B0%D0%BD%D0%B3%D0%BB%D0%B8%D0%B9%D1%81%D0%BA%D0%BE%D0%B3%D0%BE/").
          to_return(:body => test_data("rant", :en, :ru))
        @result = Smartdict::Drivers::LingvoYandexDriver.translate("rant", "en", "ru")
      end

      subject { @result }

      its(:word)          { should == "rant" }
      its(:driver)        { should == "lingvo_yandex" }
      its(:from_lang)     { should == "en" }
      its(:to_lang)       { should == "ru" }
      its(:transcription) { should == "rænt" }
      its(:translated)    { should_not be_empty }

      it { should translate_as(:noun).with("напыщенные шумные тирады", "разглагольствования") }
      it { should translate_as(:verb).with("говорить напыщенно", "изрекать", "разглагольствовать", "кричать", "говорить с напором", "зло", "шумно веселиться", "громко петь") }
    end


    describe "when there is no translation" do
      it "raises TranslationNotFound error" do
        stub_request(:get, "http://lingvo.yandex.ru/doesntexist/%D1%81+%D0%B0%D0%BD%D0%B3%D0%BB%D0%B8%D0%B9%D1%81%D0%BA%D0%BE%D0%B3%D0%BE/").
          to_return(:body => test_data("doesntexist", :en, :ru))
        expect {
          Smartdict::Drivers::LingvoYandexDriver.translate("doesntexist", "en", "ru")
        }.to raise_error(Smartdict::TranslationNotFound)
      end
    end

  end
end

