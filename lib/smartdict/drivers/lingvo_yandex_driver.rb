# encoding: utf-8

require 'cgi'
require 'nokogiri'

# TODO:
#   * Write tests
#   * Refactor
module Smartdict::Drivers
  # The translation driver for Google Translate service.
  class LingvoYandexDriver < AbstractDriver

    # Pretend being Firefox :)
    USER_AGENT = "Mozilla/5.0 (X11; U; Linux x86_64; ru; rv:1.9.1.16) Gecko/20110429 Iceweasel/3.5.16 (like Firefox/3.5.1623123)"

    # Host of Lingvo service.
    HOST = "lingvo.yandex.ru"

    # Mapping for word classes. Default is "other"
    WORD_CLASSES = {
      "имя существительное"     => "noun",
      "имя прилагательное"      => "adjective",
      "глагол"                  => "verb",
      "наречие"                 => "adverb",
      "предлог"                 => "preposition",
      "имя числительное"        => "numeral",
      "междометие (часть речи)" => "interjection",
      "сокращение"              => "abbreviation",
      "местоимение"             => "pronoun",
      "союз (часть речи)"       => "conjunction"
    }.tap{ |hash| hash.default = "other" }

    set_name "lingvo_yandex"



    # TODO: refactor
    def translate
      doc = Nokogiri::HTML(get_response)
      main_div = doc.css("div.b-translate").first

      if span = main_div.css("h1.b-translate__word > span").first
        self.transcription = span.text
      end
      self.translated = {}

      translate__value = main_div.css("div.b-translate__value")
      lis = main_div.css("div.b-translate__value > ul > li")

      lis.each do |li|
        grep_meanings(li)
      end
      if self.translated.empty?
        grep_meanings(translate__value)
      end
    end

    # TODO: refactor
    def grep_meanings(html_element)
      acronym = html_element.css("acronym").first
      return unless acronym

      ru_word_class = acronym["title"]
      word_class = WORD_CLASSES[ru_word_class]
      translations = []

      html_element.css("ul > li").each do |tr|
        # a text line with translations separated by commas
        line = ""

        # use strong tag as an anchor
        strong = tr.css("strong").first
        if strong && strong.text =~ /\d+|[а-я]+\)/
          node = strong
          while(node = node.next_sibling)
            if node.text? || node.name == "a"
              text = node.text
              line << text unless text =~ /\(|\)/
            elsif node.name == "em"
              next
            else
              break
            end
          end
        end
        translations += words_from_line(line)
      end


      # sometimes there is only one meaning
      if translations.empty?
        if a_tag = html_element.css("span > a").first
          line = a_tag.text
        elsif span = html_element.css("span").first
          line = span.text
        elsif i_tag = html_element.xpath("i[2]")
          line = i_tag.text
        else
          return nil
        end
        translations = words_from_line(line)
      end

      self.translated[word_class] = translations.uniq
    end

    def get_response
      http = Net::HTTP.new(HOST, 80)
      request = Net::HTTP::Get.new(http_path, { "User-Agent" => USER_AGENT })
      http.request(request).read_body
    end

    # @return [String] http path for request to translate word.
    def http_path
      phrase = case [from_lang, to_lang]
      when ["en", "ru"] then "с английского"
      # ru -> en does not seem to be good and it's not trivial to parse
      # when ["ru", "en"] then "по-английски"
      else raise Smartdict::TranslationNotFound
      end

      "/#{escape(word)}/#{escape(phrase)}/"
    end

    def escape(str)
      CGI.escape(str)
    end


    private

    def words_from_line(line)
      line.split(/,|;/).map(&:strip).reject(&:empty?)
    end

  end
end
