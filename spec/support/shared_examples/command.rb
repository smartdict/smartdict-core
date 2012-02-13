shared_examples_for "command" do
  it { should respond_to :execute }
  its(:name)        { should =~ /\w+/ }
  its(:summary)     { should =~ /\w+/ }
  its(:description) { should =~ /\w+/ }
  its(:syntax)      { should =~ /\w+/ }
  its(:usage)       { should =~ /\w+/ }

  it "class name should correspond the command name" do
    class_name = described_class.to_s
    basename = class_name.gsub(/^.*:/, "")
    basename.to_s.should =~ /Command$/
    name = basename.gsub(/Command$/, "")
    name.downcase.should == described_class.name
  end
end
