require 'spec_helper'

describe Smartdict::Plugin do
  describe ".initializer" do

    describe "register_command" do
      it "registers a command" do
        command_class = stub(:command_class, :command_name => :test_cmd)

        plugin = Class.new(Smartdict::Plugin) do
          initializer "test" do
            register_command command_class
          end
        end

        cmd_manager = Smartdict::Core::CommandManager.instance
        cmd_manager.find_command("test_cmd").should == command_class
      end
    end

  end
end
