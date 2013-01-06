class Smartdict::Core::FormatManager < Smartdict::Core::AbstractManager
  include Smartdict::Formats

  register "text"      , TextFormat
  register "text_color", TextColorFormat
  register "fb2"       , Fb2Format
end
