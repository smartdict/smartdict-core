class Smartdict::Drivers::GoogleTranslateDriver < Smartdict::Driver
  # pretend being Firefox :)
  USER_AGENT = "Mozilla/5.0 (X11; U; Linux x86_64; ru; rv:1.9.1.16) Gecko/20110429 Iceweasel/3.5.16 (like Firefox/3.5.1623123)" 

  def translation
    response_to_hash(get_response)
  end


  private

  # Parses string return by GoogleTranslate
  # Returns hash similar to this:
  #   { :noun => ["try", "attempt"],
  #     :verb => ["try", "offer"] }
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

  def get_response
    http_request(http_path)
  end

  def http_path
    w = word.gsub(' ', '+')
    "/translate_a/t?client=t&text=#{w}&hl=en&sl=#{from_lang}&tl=#{to_lang}&multires=1&otf=1&rom=1&ssel=0&tsel=0&sc=1"
  end

  def http_request(path)
    host = 'translate.google.com'
    http = Net::HTTP.new(host, 80)
    request = Net::HTTP::Get.new(path, {"User-Agent" => USER_AGENT})
    http.request(request).read_body
  end
end