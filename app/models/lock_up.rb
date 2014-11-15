class LockUp < ActiveRecord::Base
  has_many :users, through: :submissions
  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  reverse_geocoded_by :lat, :lon
  after_validation :reverse_geocode
end
