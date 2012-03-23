class Smartdict::Formats::AbstractFormat
  include Singleton

  class_attribute :description

  def self.set_description(description)
    self.description = description
  end

  # @param [Models::Translation] translation
  # @return [String]
  def self.format_translation(translation)
    instance.format_translation(translation)
  end

  # @param [Array] array of {Models::Translation}.
  # @return [String]
  def self.format_list(translations)
    instance.format_list(translations)
  end
end
