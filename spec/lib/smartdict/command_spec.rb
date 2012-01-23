require 'spec_helper'

describe Smartdict::Command do
  let(:command) do 
    Class.new(Smartdict::Command).new
  end


  describe 'methods' do
    it '#extract_arguments_and_options' do
      [ %w(arg1 arg2 --opt1 val1 --opt2 val2),
        %w(--opt1 val1 arg1 --opt2 val2 arg2)
      ].each do |args|
        arguments, options = command.extract_arguments_and_options(args)
        arguments.should == ["arg1", "arg2"]
        options[:opt1].should == "val1"
        options[:opt2].should == "val2"
      end
    end

    describe '.options' do
      it 'raises Smartdict::Error if other than hash is passed' do
        expect {Smartdict::Command.options "string"}.to raise_error Smartdict::Error
      end
    end
  end


  describe 'subclass' do
    before :all do
      @subclass = Class.new(Smartdict::Command) do
        arguments :arg1
        options :opt1 => "default", :opt2 => lambda { "default in block" }
        summary "subclass"
      end

      @another_subclass =Class.new(Smartdict::Command) do
        arguments :one, :two
        options :opt_one => 1
        summary "another subclass"
      end
    end

    describe "summary_message" do
      it "is not overalped" do
        @subclass.summary_message.should == "subclass"
        @another_subclass.summary_message.should == "another subclass"
      end
    end


    describe 'known_arguments' do
      it "should not be overalped" do
        @subclass.known_arguments.should == [:arg1]
        @another_subclass.known_arguments.should == [:one, :two]
      end
    end

    describe 'known_options' do
      it "should not be overalped" do
        @subclass.known_options.keys.should =~ [:opt1, :opt2]
        @another_subclass.known_options.keys.should == [:opt_one]
      end
    end

    describe 'arguments are initialized' do
      it 'with passed values' do
        command = @subclass.new %w(arg1_val)
        arguments = command.instance_variable_get('@arguments')
        arguments[:arg1].should == 'arg1_val'
      end

      it 'raises Smartdict::Error when not enough arguments are provided' do
        expect { @subclass.new }.to raise_error Smartdict::Error
      end
    end

    describe 'options are initialized' do
      it 'with passed values' do
        command = @subclass.new %w(arg1_val --opt1 opt1_val --opt2 opt2_val)
        options = command.instance_variable_get('@options')
        options[:opt1].should == 'opt1_val'
        options[:opt2].should == 'opt2_val'
      end

      it 'with static default values' do
        command = @subclass.new %w(arg1_val --opt2 opt2_val)
        options = command.instance_variable_get('@options')
        options[:opt1].should == 'default'
      end

      it 'with values defined in block' do
        command = @subclass.new %w(arg1_val)
        options = command.instance_variable_get('@options')
        options[:opt2].should == 'default in block'
      end
    end
  end
end
