module Smartdict::Formats
  extend ActiveSupport::Autoload

  autoload :AbstractFormat
  autoload :TextFormat
  autoload :TextColorFormat
  autoload :Fb2Format
end
