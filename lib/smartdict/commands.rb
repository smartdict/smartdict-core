
module Smartdict::Commands
end

require 'smartdict/command'

Dir.glob("#{File.dirname(__FILE__)}/commands/*rb").each do |file|
  require file
end
