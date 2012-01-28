module Smartdict::Core::HasLogger
  def self.included(base)
    base.extend         Methods
    base.send :include, Methods
  end

  module Methods
    def logger
      Smartdict::Core::Logger.root_logger
    end
  end
end
