module Smartdict::Core::HasLog
  def self.included(base)
    base.extend         InstanceAndClassMethods
    base.send :include, InstanceAndClassMethods
  end

  module InstanceAndClassMethods
    def log
      Smartdict::Core::Log.root_log
    end
  end
end
