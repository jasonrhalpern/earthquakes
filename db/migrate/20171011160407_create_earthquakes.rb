class CreateEarthquakes < ActiveRecord::Migration
  def change
    create_table :earthquakes do |t|
      t.time :time_of
      t.float :magnitude
      t.float :latitude
      t.float :longitude
      t.string :place
    end
  end
end
