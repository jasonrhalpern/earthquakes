class Earthquake < ActiveRecord::Base
  validates :time_of, :magnitude, :latitude, :longitude, :place, presence: true
  validates :place, uniqueness: { scope: :time_of, message: 'is already saved for this time and location.' }
end