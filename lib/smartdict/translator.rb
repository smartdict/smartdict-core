module Smartdict
  class Translator
    extend ActiveSupport::Autoload

    autoload :Base
    autoload :DriverConfiguration
    autoload :LanguageDetector

    attr_reader :default_opts

    def initialize(default_opts = {})
      @default_opts = default_opts
      @middleware_classes = [Base, DriverConfiguration, LanguageDetector]
      @middleware = build_middleware
    end

    def translate(word, opts = {})
      opts.reverse_merge!(default_opts)
      @middleware.last.call(word, opts)
    end


    private

    def build_middleware
      hooks = []
      @middleware_classes.each do |klass|
        hooks << klass.new(hooks.last)
      end
      hooks
    end
  end
end
