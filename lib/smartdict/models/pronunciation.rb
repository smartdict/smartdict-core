class Smartdict::Models::Pronunciation
  include DataMapper::Resource
  include DataMapper::Validations

  property :word_id              , Integer, :key      => true, :min => 1
  property :translation_source_id, Integer, :key      => true, :min => 1
  property :filename             , String

  belongs_to :word              , :key => true
  belongs_to :translation_source, :key => true

  validates_presence_of :filename

  attr_accessor :bin_data, :bin_data_ext

 
  # TODO: refactor condition
  before :save do
    if bin_data && bin_data_ext
      FileUtils.mkdir_p File.dirname(filepath)
      File.open(filepath, 'w') {|f| f.write bin_data}
    else
      puts 'HALT'
      p bin_data
      p bin_data_ext
      throw :halt
    end
  end

  before :valid? do
    self.filename ||= gen_filename
  end

  def filepath
    File.join(Smartdict.pronunciations_dir, translation_source.name, word.language.code, filename || gen_filename)
  end
  
  private

  def gen_filename
    escaped_word = word.name.gsub(/[\s']/, '_')
    "#{escaped_word}.#{bin_data_ext}"
  end
end
