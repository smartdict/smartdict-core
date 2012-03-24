require 'spec_helper'

describe Smartdict::Plugin do
  describe ".initializer" do

    describe "register_command" do
      it "registers a command" do
        command_class = stub(:command_class)

        plugin = Class.new(Smartdict::Plugin) do
          initializer "test" do
            register_command("test_cmd", command_class)
          end
        end

        Smartdict::Core::PluginManager.instance.load_plugins
        Smartdict::Core::CommandManager["test_cmd"].should == command_class
      end
    end

  end
end
