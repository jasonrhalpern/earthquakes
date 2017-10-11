FactoryGirl.define do
  factory :earthquake do
    time_of 1.hour.ago
    magnitude 2.1
    latitude 55.1
    longitude 101.2
    place "1km W of Los Angeles"
    distance_from_la 254.98
  end
end