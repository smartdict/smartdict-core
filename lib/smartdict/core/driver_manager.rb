# Managers {Smartdict::Driver translation drivers}.
# Similar to {Smartdict::Core::CommandManager} it registers drivers
# and provides interfaces to find them by name.
class Smartdict::Core::DriverManager
  include Singleton 
  include Smartdict::Core::HasLogger

  def initialize
    @drivers = {}
  end

  # Registers a new driver.
  # @param [Smartdict::Driver] driver_class subclass of {Smartdict::Driver}
  def register_driver(driver_class)
    name = driver_class.driver_name
    raise Smartdict::Error.new("Driver #{name} is already registed") if @drivers[name]
    @drivers[name] = driver_class 
  end
end
