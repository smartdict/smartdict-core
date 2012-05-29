module Smartdict

  class Error < ::StandardError; end


  class TranslationNotFound < Error
    def initialize(msg = "Translation is not found")
      super(msg)
    end
  end


  class MissingOption < Error
    def initialize(option)
      @option = option
    end

    def message
      "Translator option is missing: `#{@option}`"
    end
  end

end
