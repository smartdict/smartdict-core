module Smartdict::Core::IsManager
  def self.included(receiver)
    receiver.instance_variable_set("@entities", {})
    receiver.extend ClassMethods
  end

  module ClassMethods
    def register(name, klass)
      @entities[name.to_s] = klass
    end

    def [](name)
      @entities[name.to_s]
    end

    def all
      @entities
    end
  end
end
