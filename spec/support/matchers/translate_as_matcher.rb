RSpec::Matchers.define :translate_as do |word_class|
  chain(:with) do |*words|
    @words = words
  end

  match do |translation|
    @actual_words = translation.translated[word_class.to_s]
    @actual_words == @words
  end

  match_for_should_not do |model|
    raise "translate_as matcher is obsolete with should_not match"
  end

  description do
    "translates as #{word_class} with words: #{@words.inspect}"
  end

  failure_message_for_should do |model|
    "it should translate as #{word_class} with words: #{@words.inspect}\n" \
    "but actually got: #{@actual_words.inspect}"
  end
end
