class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, index: true
      t.references :lock_up, index: true

      t.timestamps
    end
  end
end
