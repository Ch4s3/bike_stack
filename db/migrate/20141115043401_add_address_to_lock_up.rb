class AddAddressToLockUp < ActiveRecord::Migration
  def change
    add_column :lock_ups, :address, :string
  end
end
