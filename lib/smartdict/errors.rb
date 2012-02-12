module Smartdict

  class Error < ::Exception; end

  class TranslationNotFound < Error
    def initialize(msg = "Translation is not found")
      super(msg)
    end
  end

end
