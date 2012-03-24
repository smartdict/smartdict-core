# Managers {Smartdict::Driver translation drivers}.
# Similar to {Smartdict::Core::CommandManager} it registers drivers
# and provides interfaces to find them by name.
class Smartdict::Core::DriverManager
  include Smartdict::Core::IsManager
  include Smartdict::Drivers

  register 'google_translate', GoogleTranslateDriver
end
