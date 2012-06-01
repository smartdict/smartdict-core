require 'csv'

module Smartdict::Storage::Seeder
  extend self

  def seed!
    seed_files.each do |csv_file|
      seed_from(csv_file)
    end
  end


  private

  def seed_files
    seeds_dir = File.expand_path('../seeds', __FILE__)
    Dir["#{seeds_dir}/*.csv"]
  end

  def seed_from(csv_file)
    model = csv_file_to_model(csv_file)
    csv = CSV.open(csv_file, 'r')
    headers = csv.shift
    while(row = csv.shift and not row.empty?)
      attrs = Hash[headers.zip(row)]
      model.create(attrs)
    end
  end

  def csv_file_to_model(csv_file)
    plural_name = File.basename(csv_file).gsub(/\.csv$/, "")
    model_name = plural_name.classify
    Smartdict::Models.const_get(model_name)
  end
end
