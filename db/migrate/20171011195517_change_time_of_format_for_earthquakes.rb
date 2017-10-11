class ChangeTimeOfFormatForEarthquakes < ActiveRecord::Migration
  def change
    change_column :earthquakes, :time_of, :datetime
  end
end
