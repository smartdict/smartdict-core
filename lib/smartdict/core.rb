module Smartdict::Core
  extend ActiveSupport::Autoload

  autoload :HasLogger
  autoload :Logger
  autoload :IsManager

  autoload :PluginManager
  autoload :CommandManager
  autoload :DriverManager
  autoload :FormatManager
end
