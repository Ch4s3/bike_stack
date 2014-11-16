class AddTotalVotesToLockUp < ActiveRecord::Migration
  def change
    add_column :lock_ups, :total_votes, :integer
  end
end
