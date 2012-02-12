module Smartdict::Seeder
  extend self

  def seed!
    seed_languages
    seed_word_classes
  end


  private

  def seed_languages
    seeds = { "en" => "English",
              "ru" => "Russian"}
    seeds.each do |code, name|
      Smartdict::Models::Language.create!(:code => code, :name => name)
    end
  end

  def seed_word_classes
    names = %w(noun adjective verb adverb preposition numeral interjection abbreviation undefined)
    names.each do |name|
      Smartdict::Models::WordClass.create!(:name => name)
    end
  end
end
