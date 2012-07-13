require 'spec_helper'

describe Smartdict::Log do

  def create_query(word, from_lang, to_lang, driver, created_at)
    from_lang = Smartdict::Models::Language[from_lang]
    to_lang   = Smartdict::Models::Language[to_lang]
    driver    = Smartdict::Models::Driver[driver]

    word = Smartdict::Models::Word.gen(:name => word, :language => from_lang)
    translation = Smartdict::Models::Translation.gen(:word => word, :from_lang => from_lang, :to_lang => to_lang, :driver => driver)
    query = Smartdict::Models::TranslationQuery.gen(:translation => translation)
    query.update!(:created_at => created_at)
  end


  def clean_storage!
    Smartdict::Models::Word.all.destroy
    Smartdict::Models::Translation.all.destroy
    Smartdict::Models::TranslationQuery.all.destroy
  end

  before :all do
    clean_storage!
    create_query("struna", :ru, :de, :lingvo_yandex   , 10.days.ago)
    create_query("hello" , :en, :ru, :google_translate, 10.days.ago)
    create_query("privet", :ru, :de, :google_translate, 5.days.ago)
    create_query("mir"   , :ru, :en, :google_translate, 1.second.ago)
    create_query("hallo" , :de, :en, :lingvo_yandex   , Time.now)
  end

  after(:all) { clean_storage! }


  describe '.fetch' do
    subject { described_class.fetch(options).map(&:word) }

    context 'without options' do
      it 'returns all translations' do
        word_names = Smartdict::Log.fetch.map(&:word)
        word_names.should =~ %w(struna hello privet hallo mir)
      end
    end

    context "with time options" do
      describe ":since" do
        let(:options) {{ :since => 7.days.ago }}
        it { should =~ %w(privet hallo mir) }
      end

      describe ":till" do
        let(:options) {{ :till => 3.days.ago }}
        it { should =~ %w(hello privet struna) }
      end

      describe ":since and :till together" do
        let(:options) {{ :till => 4.days.ago, :since => 6.days.ago }}
        it { should =~ %w(privet) }
      end
    end

    context "language options" do
      describe ":from_lang" do
        let(:options) {{ :from_lang => :ru }}
        it { should =~ %w(privet mir struna) }
      end

      describe ":to_lang" do
        let(:options) {{ :to_lang => :en }}
        it { should =~ %w(mir hallo) }
      end

      describe ":from_lang and :to_lang together" do
        let(:options) {{ :from_lang => :ru,  :to_lang => :en }}
        it { should =~ %w(mir) }
      end
    end

    describe ":driver option" do
      let(:options) {{ :driver => :google_translate }}
      it { should =~ %w(hello privet mir) }
    end

    context "sql options" do
      describe ":limit" do
        let(:options) {{ :limit => 2 }}
        its(:size) { should == 2 }
      end

      describe ":order_desc" do
        let(:options) {{ :order_desc => true, :limit => 3 }}
        it { should == %w(hallo mir privet) }
      end

      # TODO: test for unique option
    end

    context "more options together" do
      describe "nothing to return" do
        let(:options) {{ :from_lang => :en, :since => 7.days.ago }}
        it { should be_empty }
      end

      describe ":since and :from_lang" do
        let(:options) {{ :since => 7.days.ago, :from_lang => :ru }}
        it { should =~ %w(privet mir) }
      end

      describe ":till, :driver and :order_desc" do
        let(:options) {{ :since => 7.days.ago, :driver => :google_translate, :order_desc => true }}
        it { should == %w(mir privet) }
      end
    end

  end
end
