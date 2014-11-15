class LockUp < ActiveRecord::Base
  has_many :users, through: :submissions
end
