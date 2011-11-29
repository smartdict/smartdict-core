class Smartdict::Runner
  def self.run(args)
    Smartdict::Core::CommandManager.instance.run(args)
  end
end
