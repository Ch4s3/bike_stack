class AddCapacityToLockUps < ActiveRecord::Migration
  def change
    add_column :lock_ups, :capacity, :string
  end
end
