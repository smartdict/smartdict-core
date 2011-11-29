require 'logger'

class Smartdict::Core::Log < ::Logger
  def self.root_log
    @log ||= self.new(Smartdict.log_path)
  end
end
