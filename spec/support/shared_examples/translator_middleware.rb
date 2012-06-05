shared_examples_for "translator middleware" do
  describe '.new' do
    it "should receive one parameter" do
      expect { described_class.new }.to raise_error(ArgumentError, "wrong number of arguments (0 for 1)")
      expect { described_class.new(1, 2) }.to raise_error(ArgumentError, "wrong number of arguments (2 for 1)")
    end
  end

  describe '#call' do
    it "should receive 2 parameters" do
      middleware = described_class.new(stub(:translator))
      expect { middleware.call(1) }.to raise_error(ArgumentError, "wrong number of arguments (1 for 2)")
      expect { middleware.call(1, 2,3 ) }.to raise_error(ArgumentError, "wrong number of arguments (3 for 2)")
    end
  end
end
