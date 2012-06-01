# Middleware
class Smartdict::Translator::DriverConfiguration
  def initialize(translator)
    @translator = translator
  end

  def call(word, opts)
    unless opts[:driver]
      opts[:driver] = define_driver(opts[:from_lang], opts[:to_lang])
    end
    @translator.call(word, opts)
  end

  def define_driver(from_lang, to_lang)
    key = "#{from_lang}-#{to_lang}"
    conf = configatron.drivers
    conf.retrieve(key) || conf.retrieve(:default) || raise(Smartdict::Error.new("No default driver"))
  end
end
