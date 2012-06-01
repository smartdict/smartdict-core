module Smartdict::Drivers
  extend ActiveSupport::Autoload

  autoload :AbstractDriver
  autoload :GoogleTranslateDriver
  autoload :LingvoYandexDriver
end
