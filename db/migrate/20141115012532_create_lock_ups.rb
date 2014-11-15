class CreateLockUps < ActiveRecord::Migration
  def change
    create_table :lock_ups do |t|
      t.float :lat
      t.float :lon
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
