module Smartdict::Commands
  extend ActiveSupport::Autoload

  autoload :AbstractCommand
  autoload :HelpCommand
  autoload :TranslateCommand
  autoload :HelloCommand
end
