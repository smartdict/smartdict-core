require 'builder'

class Smartdict::Formats::Fb2Format < Smartdict::Formats::AbstractFormat
  set_name "fb2"
  set_description "Displays translation in fiction book format."


  def format_list(translations)
    xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct!
    xml.FictionBook(:xmlns => "http://www.gribuser.ru/xml/fictionbook/2.0") do |book|
      book.description do |desc|
        desc.tag!("document-info") do |doc_info|
          doc_info.tag!("program-used", "Smartdict version #{Smartdict::VERSION}")
        end
        desc.tag!('title-info') do |title_info|
          title_info.tag!('book-title', "#{Time.now.strftime('%F')} - English words")
          title_info.genre 'sci_linguistic'
          title_info.annotation do |annotation|
            annotation.p "English words to learn"
            annotation.p "The content generate by program Smardict v#{Smartdict::VERSION}"
          end
        end
      end
      book.body do |body|
        body.title "TITLE"
        translations.each do |translation|
          body.section do |word_section|
            word_section.title {|title| title.p "#{translation.word}   [#{translation.transcription}]"}
            translation.translated.each do |word_class, translations|
              word_section.subtitle word_class
              word_section.p translations.join("; ")
              word_section.tag!("empty-line")
            end
          end
        end
      end
    end
  end

end