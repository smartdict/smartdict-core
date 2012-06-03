#encoding: utf-8

require 'spec_helper'

describe Smartdict::Translator::LanguageDetector do
  it_behaves_like "translator middleware"

  describe "#call" do
    let(:translator) { stub(:translator) }
    let(:detector)   { described_class.new(translator) }

    it "exchanges :from and :to options if it's reasonable language of word is detected" do
      translator.should_receive(:call).with("Мир", :from_lang => :ru, :to_lang => :en)
      detector.call("Мир", :from_lang => :en, :to_lang => :ru)
    end

    it "ignores spaces" do
      translator.should_receive(:call).with("Hello World", :from_lang => :en, :to_lang => :ru)
      detector.call("Hello World", :from_lang => :ru, :to_lang => :en)
    end

    it "ignores dashes" do
      translator.should_receive(:call).with("что-то", :from_lang => :ru, :to_lang => :en)
      detector.call("что-то", :from_lang => :en, :to_lang => :ru)
    end

    it "doesn't exchange options when can't detect language exactly" do
      translator.should_receive(:call).with("Hi Привет", :from_lang => :ru, :to_lang => :en)
      detector.call("Hi Привет", :from_lang => :ru, :to_lang => :en)
    end

    it "doesn't exchange options when there is no need" do
      translator.should_receive(:call).with("truth", :from_lang => :en, :to_lang => :ru)
      detector.call("truth", :from_lang => :en, :to_lang => :ru)
    end


    describe "languages" do
      describe "Russian and English" do
        it_behaves_like "language detector",
          :en => ["Hi", "Dangerous", "fight", "Zachary"],
          :ru => ["Привет", "сегодня", "Рыба", "что-нибудь"]
      end

      describe "Russian and Ukrainian" do
        it_behaves_like "language detector",
          :ru => ["Эстетика", "Берёза", "Рыба", "подъезд"],
          :uk => ["Квітка", "П'ять", "здається", "ґудзик", "Їжачок"]
      end

      describe "German and English" do
        it_behaves_like "language detector",
          :de => ["Mütter", "groß", "Länge", "Stöhnen"],
          :en => []
      end

      describe "Spanish and German" do
        it_behaves_like "language detector",
          :es => ["Antaño"],
          :de => ["Mütter", "groß", "Länge", "Stöhnen"]
      end
    end
  end
end
