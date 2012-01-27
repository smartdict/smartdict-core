$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'dm-sweatshop'
# require dm-spec(DataMapperMatchers)
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../vendor/dm-rspec/lib'))
require 'dm-rspec'

require 'smartdict'
require File.join(File.dirname(__FILE__), 'factories')

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# require custom matchers
Dir.glob("#{File.dirname(__FILE__)}/matchers/*").each {|file| require file}

RSpec.configure do |config|
  #config.include(Smartdict::Matchers)
  config.include(DataMapper::Matchers)
end


Smartdict.env = :test
#Smartdict.configure do |config|
#  config.store.adapter  = 'sqlite'
#  config.store.db = 'memory'
#end
#Smartdict.run
