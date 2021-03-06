require 'rspec'
require 'dm-rspec'
require 'dm-sweatshop'
require 'webmock/rspec'
require 'pry'

load File.expand_path("../../.simplecov", __FILE__) if RUBY_VERSION =~ /^1\.9/

require 'smartdict'

require File.join(File.dirname(__FILE__), 'factories')
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include(DataMapper::Matchers)
end

Smartdict.env = :test
Smartdict.run
