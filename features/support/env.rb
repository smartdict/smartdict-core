require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'smartdict'

require 'rspec/expectations'
require 'aruba/cucumber'

ENV["SMARTDICT_ENV"] = 'cucumber'
ENV['PATH'] = "#{Smartdict.root_dir}/bin:" + ENV['PATH']

Smartdict.env = :cucumber
FileUtils.rm_rf(Smartdict.user_dir)

Before do
  @aruba_timeout_seconds = 10
end
