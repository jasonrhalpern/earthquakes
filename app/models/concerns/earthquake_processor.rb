require 'active_support/concern'
require 'csv'

module EarthquakeProcessor
  extend ActiveSupport::Concern

  class << self

    def process_file(csv_file)
      CSV.foreach(csv_file, :headers => true) do |row|
        row = row.to_hash
        earthquake = Earthquake.new(time_of: row['time'], magnitude: row['mag'], latitude: row['latitude'],
                                    longitude: row['longitude'], place: row['place'])
        earthquake.distance_from_la = HaversineCalculator.distance_from_la(earthquake)
        earthquake.felt_in_la = felt_in_la?(earthquake)
        earthquake.save
      end
    end

    def felt_in_la?(earthquake)
      return false unless earthquake.distance_from_la && earthquake.magnitude

      earthquake.distance_from_la <= earthquake.magnitude * 100
    end

  end

  module HaversineCalculator
    LA_LATITUDE = 34.0522
    LA_LONGITUDE = -118.2437
    EARTHS_RADIUS = 3959

    class << self

      def distance_from_la(earthquake)
        a = find_a(earthquake)
        c = find_c(a)
        find_d(c)
      end

      def find_a(earthquake)
        la_lat = degrees_to_radians(LA_LATITUDE)
        la_long= degrees_to_radians(LA_LONGITUDE)
        earthquake_lat = degrees_to_radians(earthquake.latitude)
        earthquake_long = degrees_to_radians(earthquake.longitude)

        sin_lat = Math.sin((la_lat - earthquake_lat) / 2)
        sin_long = Math.sin((la_long - earthquake_long) / 2)

        sin_lat * sin_lat + Math.cos(earthquake_lat) * Math.cos(la_lat) * sin_long * sin_long
      end

      def find_c(a)
        2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      end

      def find_d(c)
        EARTHS_RADIUS * c
      end

      def degrees_to_radians(degrees)
        degrees * Math::PI / 180
      end

    end
  end
end