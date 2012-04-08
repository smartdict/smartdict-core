# Extends {help_message} method to provide list of formats.
module Smartdict::Commands::HasFormatList
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      class << self
        alias_method_chain :help_message, :formats
      end
    end
  end

  module ClassMethods
    def help_message_with_formats
      formats = Smartdict::Core::FormatManager.all
      width = formats.values.map{|f| f.name.size}.max
      indent = Smartdict::Commands::AbstractCommand::INDENT_SIZE

      message  = " " * indent + "Formats:\n"
      formats.each do |name, format|
        message << " " * 2 * indent
        message << name.ljust(width) + "    "
        message << "#{format.description}\n"
      end

      help_message_without_formats << message
    end
  end
end
