require 'spec_helper'

describe Smartdict::ListBuilder do

  def create_query(word, options = {})
    from_lang = Smartdict::Models::Language[options[:from]]
    to_lang = Smartdict::Models::Language[options[:to]]

    word = Smartdict::Models::Word.gen(:name => word, :language => from_lang)
    translation = Smartdict::Models::Translation.gen(:word => word, :from_lang => from_lang, :to_lang => to_lang)
    query = Smartdict::Models::TranslationQuery.gen(:translation => translation)
    query.update!(:created_at => options[:created_at])
  end


  def clean_storage!
    Smartdict::Models::Word.all.destroy
    Smartdict::Models::Translation.all.destroy
    Smartdict::Models::TranslationQuery.all.destroy
  end

  before :all do
    clean_storage!
    create_query("struna", :from => :ru, :to => :de, :created_at => 10.days.ago)
    create_query("hello" , :from => :en, :to => :ru, :created_at => 10.days.ago)
    create_query("privet", :from => :ru, :to => :de, :created_at => 5.days.ago)
    create_query("mir"   , :from => :ru, :to => :en, :created_at => Time.now)
    create_query("hallo" , :from => :de, :to => :en, :created_at => Time.now)
  end

  after(:all) { clean_storage! }


  describe '.build' do
    subject { Smartdict::ListBuilder.build(options).map(&:word) }

    context 'without options' do
      it 'returns all translations' do
        word_names = Smartdict::ListBuilder.build.map(&:word)
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

    context "more options together" do
      describe "nothing to return" do
        let(:options) {{ :from_lang => :en, :since => 7.days.ago }}
        it { should be_empty }
      end

      describe ":since and :from_lang" do
        let(:options) {{ :since => 7.days.ago, :till => Time.now, :from_lang => :ru }}
        it { should =~ %w(privet mir) }
      end
    end

    # TODO: when there are more than 1 driver
    it ":driver option"


  end
end
