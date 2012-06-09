require 'singleton'

module Smartdict
  class Info < Struct.new(:version, :author, :email, :url)
    include Singleton

    def initialize
      self.version = Smartdict::VERSION
      self.author  = "Sergey Potapov"
      self.email   = "open.smartdict@gmail.com"
      self.url     = "http://smartdict.net"
    end
  end
end
