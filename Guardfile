
ignore_paths '.git'

guard 'rspec', :version => 2, :cli => "--color --format nested" do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/#{m[1]}_spec.rb" }
end
