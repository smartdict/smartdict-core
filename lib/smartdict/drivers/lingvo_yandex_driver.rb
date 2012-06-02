# encoding: utf-8

require 'cgi'
require 'nokogiri'

module Smartdict::Drivers
  # The translation driver for Google Translate service.
  #
  # DISCLAIMER:
  # It's was written when I had one hand broken. Refactoring costs a lot of
  # movements so that I've left it as it was. I'm gonna refactor it soon.
  # -- Sergey Potapov
  #
  # TODO:
  #   * Refactor
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

      if main_div = doc.css("div.b-translate > div.b-translate__value > ul > li#I").first
        translate__value = main_div
      else
        main_div = doc.css("div.b-translate").first
        translate__value = main_div.css("div.b-translate__value")
      end

      # Fetch transcription
      self.transcription = main_div.xpath('(.//span[@class="b-translate__tr"])[1]').try(:text)

      self.translated = {}

      if translate__value.xpath("./i/acronym").any?
        grep_meanings(translate__value)
      else
        translate__value.xpath("./ul/li").each do |li|
          grep_meanings(li)
        end
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
            elsif ["em", "acronym"].include? node.name
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
