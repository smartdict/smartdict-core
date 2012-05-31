RSpec::Matchers.define :translate_as do |word_class|
  chain(:with) do |*words|
    @words = words
  end

  match do |translation|
    translation.translated[word_class.to_s] == @words
  end

  match_for_should_not do |model|
    raise "translate_as matcher is obsolete with should_not match"
  end

  description do
    "translates as #{word_class} with words: #{@words.inspect}"
  end

  failure_message_for_should do |model|
    "should not translates as #{word_class} with words: #{@words.inspect}"
  end
end
