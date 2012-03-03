module Smartdict::Storage
  extend self
  extend ActiveSupport::Autoload

  autoload :Seeder

  include Smartdict::Models

  def prepare!
    #DataMapper::Logger.new(STDOUT, :debug)
    setup_sqlite
    update_enums_cache
  end


  private

  def setup_sqlite
    DataMapper.setup(:default, storage_line)
    DataMapper.finalize
    if migrate_and_seed?
      DataMapper.auto_migrate!
      Seeder.seed!
    end
  end

  def update_enums_cache
    [Language, Driver, WordClass].each do |model_class|
      model_class.update_enums_cache!
    end
  end

  def storage_line
    (Smartdict.env == :test) ? "sqlite::memory:" : "sqlite://#{db_file}"
  end

  def migrate_and_seed?
    storage_line =~ /memory/ or !File.exists?(db_file)
  end

  def db_file
    "#{Smartdict.user_dir}/database.sqlite"
  end
end