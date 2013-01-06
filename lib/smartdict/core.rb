module Smartdict::Core
  extend ActiveSupport::Autoload

  autoload :HasLogger
  autoload :Logger
  autoload :AbstractManager

  autoload :PluginManager
  autoload :CommandManager
  autoload :DriverManager
  autoload :FormatManager
end
