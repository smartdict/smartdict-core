module HelloWorld
  class Plugin < Smartdict::Plugin
    initializer 'hello_world' do
      register_command "hello", HelloWorld::HelloCommand
    end
  end
end
