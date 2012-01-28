class Smartdict::Core::Logger < ::Logger
  def self.root_logger
    @logger ||= self.new(Smartdict.log_path)
  end
end
