module Smartdict::Core; end

require 'smartdict/core/has_log'

Dir.glob("#{File.dirname(__FILE__)}/core/*rb").each do |file|
  require file
end
