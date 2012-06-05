shared_examples_for "language detector" do |options|
  lang1, words1 = options.shift
  lang2, words2 = options.shift

  let(:translator) { stub(:translator) }
  let(:detector)   { described_class.new(translator) }

  describe lang1 do
    words1.each do |word|
      it word do
        translator.should_receive(:call).with(word, :from_lang => lang1, :to_lang => lang2)
        detector.call(word, :from_lang => lang2, :to_lang => lang1)
      end
    end
  end

  describe lang2 do
    words2.each do |word|
      it word do
        translator.should_receive(:call).with(word, :from_lang => lang2, :to_lang => lang1)
        detector.call(word, :from_lang => lang1, :to_lang => lang2)
      end
    end
  end


  describe "Mixed #{lang1} and #{lang2}" do
    words1.each do |word1|
      words2.each do |word2|
        word = "#{word1} #{word2}"

        it word do
          translator.should_receive(:call).with(word, :from_lang => lang1, :to_lang => lang2)
          detector.call(word, :from_lang => lang1, :to_lang => lang2)

          translator.should_receive(:call).with(word, :from_lang => lang2, :to_lang => lang1)
          detector.call(word, :from_lang => lang2, :to_lang => lang1)
        end

      end
    end
  end


end
