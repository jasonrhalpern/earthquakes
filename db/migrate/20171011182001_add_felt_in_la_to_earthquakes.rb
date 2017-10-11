class AddFeltInLaToEarthquakes < ActiveRecord::Migration
  def change
    add_column :earthquakes, :felt_in_la, :boolean
  end
end
