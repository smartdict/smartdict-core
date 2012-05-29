# The very basic translator middleware.
module Smartdict
  class Translator::Base
    # Just to make the interface compatible
    def initialize(translator = nil)
    end

    def call(word, opts)
      validate_opts!(opts)
      driver = Smartdict::Core::DriverManager.find(opts[:driver])

      translation_model = Models::Translation.find(word, opts[:from_lang], opts[:to_lang], opts[:driver])
      unless translation_model
        translation = driver.translate(word, opts[:from_lang], opts[:to_lang])
        translation_model = Models::Translation.create_from_struct(translation)
      end
      log_query(translation_model) if opts[:log]
      translation_model.to_struct
    end


    private

    def validate_opts!(opts)
      required_opts = [:from_lang, :to_lang, :driver, :log]
      required_opts.each do |opt|
        raise(MissingOption.new(opt)) if opts[opt].nil?
      end
    end

    def log_query(translation)
      Models::TranslationQuery.create(:translation => translation)
    end
  end
end
