class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :lock_ups, through: :submissions
  has_attached_file :bike_photo, 
                    :styles => { :medium => "400x400>", :thumb => "200x200>" }, 
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :bike_photo, :content_type => /\Aimage\/.*\Z/

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
