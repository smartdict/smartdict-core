# Managers {Smartdict::Driver translation drivers}.
# Similar to {Smartdict::Core::CommandManager} it registers drivers
# and provides interfaces to find them by name.
class Smartdict::Core::DriverManager < Smartdict::Core::AbstractManager
  include Smartdict::Drivers

  register 'google_translate', GoogleTranslateDriver
  register 'lingvo_yandex'   , LingvoYandexDriver
end
