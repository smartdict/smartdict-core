RSpec::Matchers.define :include_hash do |subhash|
  match do |hash|
    @hash = hash
    raise("#{hash.inspect} is not a Hash") unless hash.is_a? Hash
    subhash.each do |key, value|
      unless hash.has_key?(key)
        @explain_msg = "has no key #{key.inspect}"
        @failed = true
      end
      if hash[key] != value
        @explain_msg = "key #{key.inspect} has value #{hash[key].inspect}"
        @failed = true
      end
    end
    !@failed
  end

  failure_message_for_should { "Expected #{@hash.inspect} to #{description}. But #{@explain_msg}" }
  failure_message_for_should_not { "expected to not #{description}" }
  description { "include hash #{subhash.inspect}" }
end
