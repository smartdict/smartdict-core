class Smartdict::Plugin
  extend ActiveSupport::Autoload

  autoload :Initializer

  def self.initializer(name, &block)
    Initializer.new.instance_eval &block
  end
end
