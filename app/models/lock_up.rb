class LockUp < ActiveRecord::Base
  acts_as_votable
  has_many :users, through: :submissions
  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  reverse_geocoded_by :lat, :lon
  after_validation :reverse_geocode
  has_attached_file :photo, 
                    :styles => { :medium => "400x400>", :thumb => "150x150>" }, 
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
  def to_json_with_photo_url
    spot_json = JSON.parse(self.to_json)
    spot_json['url'] = self.photo.url(:medium) || ''
    return spot_json
  end
  def to_json_with_photo_url_thumb
    spot_json = JSON.parse(self.to_json)
    spot_json['url'] = self.photo.url(:thumb) || ''
    return spot_json
  end
end
