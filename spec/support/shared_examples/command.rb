shared_examples_for "command" do
  it { should respond_to :execute }
  its(:command_name)        { should =~ /\w+/ }
  its(:summary_message)     { should =~ /\w+/ }
  its(:description_message) { should =~ /\w+/ }
  its(:syntax_message)      { should =~ /\w+/ }
  its(:usage_message)       { should =~ /\w+/ }

  it "class name should correspond the command name" do
    class_name = described_class.to_s
    basename = class_name.gsub(/^.*:/, "")
    basename.to_s.should =~ /Command$/
    name = basename.gsub(/Command$/, "")
    name.downcase.should == described_class.command_name
  end
end
