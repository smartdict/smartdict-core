module Smartdict::Core::HasLog
  def self.included(base)
    base.extend         Methods
    base.send :include, Methods
  end

  module Methods
    def logger
      Smartdict::Core::HasLog::Logger.logger
    end
  end
end
