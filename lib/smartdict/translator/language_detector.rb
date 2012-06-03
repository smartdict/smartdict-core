#encoding: utf-8

# It's a translator middleware which tries to identify a language of the
# passed word basing on :from_lang and :to_lang options. If it's possible to
# explicitly identify a language and :from_lang and :to_lang options are
# required to be exchanged it exchanges them.
#
# Example:
#   detector = LanguageDetector.new(translator)
#   detector.call("groß", :from_lang => :en, :to_lang => :de)
#   # It delegates call to translator like this:
#   #   translator.call("groß", :from_lang => :de, :to_lang => :en)
#   # Because in English there is no character "ß" but it exists in German.
class Smartdict::Translator::LanguageDetector

  CHARS = {
    :ru => %w(А а Б б В в Г г Д д Е е Ё ё Ж ж З з И и Й й К к Л л М м Н н О о П п Р р С с Т т У у Ф ф Х х Ц ц Ч ч Ш ш Щ щ Ъ ъ Ы ы Ь ь Э э Ю ю Я я),
    :en => %w(a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z),
    :uk => %w(А а Б б В в Г г Ґ ґ Д д Е е Є є Ж ж З з И и І і Ї ї Й й К к Л л М м Н н О о П п Р р С с Т т У у Ф ф Х х Ц ц Ч ч Ш ш Щ щ Ь ь Ю ю Я я '),
    :de => %w(a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z Ä ä Ö ö Ü ü ß),

    # TODO: Add vowels with stresses
    :es => %w(A a B b С с D d E e F f G g H h I i J j K k L l M m N n Ň ñ O o P p Q q R r S s T t U u V v W w X x Y y Z z)
  }

  def initialize(translator)
    @translator = translator

    @matchers = {}
    CHARS.each do |lang, chars|
      @matchers[lang] = Matcher.new(chars)
    end
  end

  def call(word, opts)
    if exchange?(word, opts[:from_lang], opts[:to_lang])
      opts[:to_lang], opts[:from_lang] = opts[:from_lang], opts[:to_lang]
    end
    @translator.call(word, opts)
  end


  private

  def exchange?(word, from_lang, to_lang)
    from_matcher = @matchers[from_lang.to_sym]
    to_matcher   = @matchers[to_lang.to_sym]
    return false unless [from_matcher, to_matcher].all?
    to_matcher.match?(word) && !from_matcher.match?(word)
  end



  class Matcher
    def initialize(chars)
      @chars = chars + [" ", "-"]
    end

    def match?(word)
      word.each_char do |char|
        return false unless @chars.include? char
      end
      true
    end
  end
end
