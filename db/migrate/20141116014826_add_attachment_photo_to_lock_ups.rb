class AddAttachmentPhotoToLockUps < ActiveRecord::Migration
  def self.up
    change_table :lock_ups do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :lock_ups, :photo
  end
end
