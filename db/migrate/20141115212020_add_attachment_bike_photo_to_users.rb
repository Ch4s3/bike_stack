class AddAttachmentBikePhotoToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :bike_photo
    end
  end

  def self.down
    remove_attachment :users, :bike_photo
  end
end
