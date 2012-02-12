class Smartdict::Core::FormatManager
  include Singleton
  include Smartdict::Core::HasLogger
  include Smartdict::Formats

  attr_reader :formats

  def initialize
    @formats = {}
    register_format TextFormat
    register_format TextColorFormat
  end

  def register_format(format_class)
    name = format_class.name
    raise Smartdict::Error.new("Format `#{name}` is already registed") if find_format(name)
    @formats[name] = format_class
  end

  def find_format(name)
    @formats[name.to_s]
  end
end
