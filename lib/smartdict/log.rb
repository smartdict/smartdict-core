class Smartdict::Log
  include Smartdict::Models

  # Options:
  # * +:since+
  # * +:till+
  # * +:from_lang+
  # * +:to_lang+
  # * +:driver+
  # * +:limit+
  # * +:order_desc+
  # * +:unique+
  #
  # @return [Array] array of {Smartdict::Translation}.
  def self.fetch(options = {})
    new(options).send(:fetch)
  end


  private

  def initialize(options)
    @options = options
  end

  def fetch
    fetch_translations.map(&:to_struct)
  end



  # Unfortunately it's not possible to build necessary query with DataMapper
  # TODO: Refactor in QueryBuilder class.
  def fetch_translations
    adapter = Translation.repository.adapter

    translations_table = Translation.storage_name
    queries_table = TranslationQuery.storage_name

    sql = "SELECT #{'DISTINCT' if @options[:unique]} #{translations_table}.* \n" \
          "FROM #{translations_table} \n" \
          "INNER JOIN #{queries_table} ON \n" \
          "  #{queries_table}.translation_id == #{translations_table}.id"

    if [:till, :since, :from_lang, :to_lang, :driver].any? {|opt| @options[opt] }
      sql << " WHERE "

      if @options[:till]
        till = @options[:till].is_a?(String) ? Date.parse(@options[:till]) : @options[:till]
        sql << " #{queries_table}.created_at < \"#{till.to_s(:db)}\" "
        where = true
      end

      if @options[:since]
        sql << " AND " if where
        since = @options[:since].is_a?(String) ? Date.parse(@options[:since]) : @options[:since]
        sql << " #{queries_table}.created_at >  \"#{since.to_s(:db)}\" "
        where = true
      end

      if from_lang
        sql << " AND " if where
        sql << " #{translations_table}.from_lang_id = #{from_lang.id} "
        where = true
      end

      if to_lang
        sql << " AND " if where
        sql << " #{translations_table}.to_lang_id = #{to_lang.id} "
        where = true
      end

      if driver
        sql << " AND " if where
        sql << " #{translations_table}.driver_id = #{driver.id} "
        where = true
      end
    end

    if @options[:order_desc]
      sql << " ORDER BY #{queries_table}.created_at DESC "
    else
      sql << " ORDER BY #{queries_table}.created_at "
    end

    if @options[:limit]
      sql << " LIMIT #{@options[:limit]} "
    end

    translation_structs = adapter.select(sql)

    result = []
    translation_structs.each do |struct|
      translation = Translation.first(:id => struct.id)
      result << translation
    end

    return result
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
