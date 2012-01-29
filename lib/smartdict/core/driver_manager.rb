class Smartdict::Core::DriverManager
  include Singleton 
  include Smartdict::Core::HasLogger

  def initialize
    @drivers = {}
  end

  def register_driver(driver_class)
    name = driver_class.name.to_s
    raise Smartdict::Error.new("Driver #{name} is already registed") if @drivers[name]
    @drivers[name] = driver_class 
  end
end