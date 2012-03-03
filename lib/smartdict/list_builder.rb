# TODO: tests

class Smartdict::ListBuilder
  include Smartdict::Models

  # Options:
  # * +:since+
  # * +:till+
  # * +:from_lang+
  # * +:to_lang+
  # * +:driver+
  #
  # @return [Array] array of {Smartdict::Translation}.
  def self.build(options = {})
    new(options).send(:build)
  end


  private

  def initialize(options)
    @options = options
    @options[:till] ||= Time.now
  end

  def build
    fetch_translations.map(&:to_struct)
  end

  def fetch_translations
    query = Translation.all(Translation.translation_queries.created_at.lte => @options[:till])
    query = query.all(Translation.translation_queries.created_at.gte => @options[:since]) if @options[:since]
    query = query.all(Translation.to_lang_id   => to_lang.id)   if to_lang
    query = query.all(Translation.from_lang_id => from_lang.id) if from_lang
    query = query.all(Translation.driver_id    => driver.id)    if driver
    query
  end

  def from_lang
    Language[@options[:from_lang]]
  end

  def to_lang
    Language[@options[:to_lang]]
  end

  def driver
    Driver[@options[:driver]]
  end

end
