# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name        = "smartdict-core"
  gem.homepage    = "http://github.com/smartdict/smartdict-core"
  gem.license     = "GNU GPL v2"
  gem.summary     = "CLI dictionary"
  gem.description = "CLI dictionary created to help you to learn foreign languages."
  gem.email       = "blake131313@gmail.com"
  gem.authors     = ["Potapov Sergey"]

  gem.files = Dir.glob('./lib/**/*')
  gem.files += ['bin/smartdict', 'config/default_config.yml', 'GPL-LICENSE.txt', 'VERSION']
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
