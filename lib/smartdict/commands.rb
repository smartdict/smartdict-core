module Smartdict::Commands
  extend ActiveSupport::Autoload

  autoload :AbstractCommand
  autoload :HelpCommand
  autoload :VersionCommand
  autoload :TranslateCommand
  autoload :ListCommand

  autoload :HasFormatList
end
