class ChangeSetDefaultTotalVotes < ActiveRecord::Migration
  def change
    change_column :lock_ups, :total_votes, :integer, :default => 0
  end
end
