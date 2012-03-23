class Smartdict::Core::FormatManager
  include Smartdict::Formats
  include Smartdict::Core::IsManager

  register "text"      , TextFormat
  register "text_color", TextColorFormat
  register "fb2"       , Fb2Format
end
