class AddDistanceFromLaToEarthquakes < ActiveRecord::Migration
  def change
    add_column :earthquakes, :distance_from_la, :float
  end
end
