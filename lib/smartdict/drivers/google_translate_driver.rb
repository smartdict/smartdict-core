# The translation driver for Google Translate service.
class Smartdict::Drivers::GoogleTranslateDriver < Smartdict::Driver

  # Pretend being Firefox :)
  USER_AGENT = "Mozilla/5.0 (X11; U; Linux x86_64; ru; rv:1.9.1.16) Gecko/20110429 Iceweasel/3.5.16 (like Firefox/3.5.1623123)" 

  # Host of Google Translate service.  
  HOST = "translate.google.com"

  # Sets translation and transcription. GoogleTranslate doesn't provide
  # transcription, so it's nil.
  def translate
    self.translated = response_to_hash(get_response)
    self.transcription = nil
  end


  private

  # Parses string return by GoogleTranslate
  # Returns hash similar to this:
  #   { "noun" => ["try", "attempt"],
  #     "verb" => ["try", "offer"] }
  # If no translation was found than returns nil.
  # @return [Hash] every key is word class and every value is array of translated words.
  def response_to_hash(response)
    result = {}
    array = YAML.load(response.gsub(/,+/, ', '))
    array[1].each do |trans|
      word_class = trans[0].empty? ? 'undefined' : trans[0]
      result[word_class] = trans[1]
    end
    result
  rescue NoMethodError
    nil
  end

  # Sends remote request to GooogleTranslate service.
  # @return [String] body of response.
  def get_response
    http = Net::HTTP.new(HOST, 80)
    request = Net::HTTP::Get.new(http_path, {"User-Agent" => USER_AGENT})
    http.request(request).read_body
  end

  # @return [String] http path for request to translate word.
  def http_path
    w = word.gsub(' ', '+')
    "/translate_a/t?client=t&text=#{w}&hl=en&sl=#{from_lang}&tl=#{to_lang}&multires=1&otf=1&rom=1&ssel=0&tsel=0&sc=1"
  end
end
