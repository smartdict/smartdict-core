class Smartdict::Formats::AbstractFormat
  include Singleton

  class_attribute :name
  class_attribute :description

  def self.set_name(name)
    self.name = name.to_s
  end

  def self.set_description(description)
    self.description = description
  end

  def self.format_translation(translation)
    instance.format_translation(translation)
  end

  def self.format_list(translations)
    instance.format_list(translation)
  end
end
