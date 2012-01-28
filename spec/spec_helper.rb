require 'rspec'
require 'dm-rspec'
require 'dm-sweatshop'

require 'smartdict'

require File.join(File.dirname(__FILE__), 'factories')
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include(DataMapper::Matchers)
end

Smartdict.env = :test
Smartdict.run
