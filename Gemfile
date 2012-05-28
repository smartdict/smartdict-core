source "http://rubygems.org"

def ruby18?; RUBY_VERSION =~ /^1\.8/ ; end
def ruby19?; RUBY_VERSION =~ /^1\.9/ ; end

gem 'dm-core'
gem 'dm-validations'
gem 'dm-enum'
gem 'dm-migrations'
gem 'dm-sqlite-adapter'

gem 'configatron'
gem 'activesupport'

gem "builder"
gem "nokogiri"


group :development, :test do
  gem 'guard'
  gem 'libnotify'
  gem 'guard-rspec'
  gem 'rb-readline'
  gem 'pry'

  gem "yard", "~> 0.6.0"
  gem "rspec"
  gem "aruba"

  gem "bundler", "~> 1.1.2"
  gem "jeweler", "~> 1.6.4"

  gem 'dm-sweatshop'
  gem 'dm-rspec'
  gem 'webmock'

  if ruby19?
    gem 'simplecov'    , :require => false
    gem 'simplecov-vim', :require => false
  end
end
