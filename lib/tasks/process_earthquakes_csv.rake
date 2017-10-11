namespace :process_earthquakes_csv do
  desc 'Imports a CSV file with earthquake data into the earthquakes table'
  task :create_earthquakes => :environment do
    EarthquakeProcessor.process_file("#{Rails.root}/lib/all_month.csv")
  end
end