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
        stub_request(:get, "http://slovari.yandex.ru/one/en-ru/").
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
      it { should translate_as(:noun).with("единица", "один", "одиночка", "час", "однодолларовая купюра купюра достоинством один фунт стерлингов", "история", "анекдот", "байка") }
      it { should translate_as(:pronoun).with("кто-то", "некий", "некто") }
      it { should translate_as(:adjective).with("единственный", "уникальный", "определённый", "единственный в своём роде", "одинаковый", "такой же", "какой-то", "некий", "неопределённый", "очень", "крайне") }
    end


    describe "word 'survive'" do
      before :all do
        stub_request(:get, "http://slovari.yandex.ru/survive/en-ru/").
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
        stub_request(:get, "http://slovari.yandex.ru/rant/en-ru/").
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


    describe "word 'obsolete'" do
      before :all do
        stub_request(:get, "http://slovari.yandex.ru/obsolete/en-ru/").
          to_return(:body => test_data("obsolete", :en, :ru))
        @result = Smartdict::Drivers::LingvoYandexDriver.translate("obsolete", "en", "ru")
      end

      subject { @result }

      its(:word)          { should == "obsolete" }
      its(:driver)        { should == "lingvo_yandex" }
      its(:from_lang)     { should == "en" }
      its(:to_lang)       { should == "ru" }
      its(:transcription) { should == "'ɔbs(ə)liːt" }
      its(:translated)    { should_not be_empty }

      it { should translate_as(:adjective).with("устарелый", "вышедший из употребления", "старомодный", "исчезающий", "остаточный", "рудиментарный") }
    end


    describe "word 'sing'" do
      before :all do
        stub_request(:get, "http://slovari.yandex.ru/sing/en-ru/").
          to_return(:body => test_data("sing", :en, :ru))
        @result = Smartdict::Drivers::LingvoYandexDriver.translate("sing", "en", "ru")
      end

      subject { @result }

      its(:word)          { should == "sing" }
      its(:driver)        { should == "lingvo_yandex" }
      its(:from_lang)     { should == "en" }
      its(:to_lang)       { should == "ru" }
      its(:transcription) { should == "sɪŋ" }
      its(:translated)    { should_not be_empty }

      it { should translate_as(:verb).with("петь", "напевать", "издавать трели", "заливаться", "кукарекать", "каркатькричать", "квакать", "сверчать", "трещать", "звенеть", "стрекотать", "издавать звуки при игре", "стучать", "доносить", "гудетьсвистеть", "звенеть в ушах", "испытывать звон в ушах", "воспевать", "прославлять", "ликовать", "читать нараспев", "сопровождать пением") }
      it { should translate_as(:noun).with("свист", "шумзвон", "стрекотаниезвон", "пение", "пение хором в своей компании", "спевка") }
    end


    describe "when there is no translation" do
      it "raises TranslationNotFound error" do
        stub_request(:get, "http://slovari.yandex.ru/doesntexist/en-ru/").
          to_return(:body => test_data("doesntexist", :en, :ru))
        expect {
          Smartdict::Drivers::LingvoYandexDriver.translate("doesntexist", "en", "ru")
        }.to raise_error(Smartdict::TranslationNotFound)
      end
    end

  end
end
