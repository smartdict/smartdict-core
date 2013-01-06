class Smartdict::Core::AbstractManager
  def self.register(name, klass)
    raise Smartdict::Error.new("`#{name}` is already registered") if find(name)
    entities[name.to_s] = klass
  end

  def self.find(name)
    entities[name.to_s]
  end

  def self.all
    entities
  end

  def self.entities
    @entities ||= {}
  end
end
