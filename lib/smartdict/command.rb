class Smartdict::Command
  def self.run(args)
    self.new(args).execute
  end

  def initialize(args)
    @arguments, @options = extract_arguments_and_options(args)
  end

  def extract_arguments_and_options(args)
    
  end
end
