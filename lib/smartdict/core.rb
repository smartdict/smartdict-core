module Smartdict::Core
  extend ActiveSupport::Autoload

  autoload :HasLogger
  autoload :Logger
  autoload :PluginManager
  autoload :CommandManager
  autoload :DriverManager
  autoload :FormatManager
end
