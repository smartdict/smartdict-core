module Smartdict::Models; end

# rubygems
require 'dm-core'          #, '1.0.2'
require 'dm-validations'   #, '1.0.2'
require 'dm-migrations'    #, '1.0.2'
require 'dm-sqlite-adapter'#, '1.0.2'

# models
%w{language pronunciation translation translation_query translation_source word word_class}.each do |model|
  require "smartdict/models/#{model}"
end
