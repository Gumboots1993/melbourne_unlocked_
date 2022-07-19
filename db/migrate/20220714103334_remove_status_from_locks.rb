class RemoveStatusFromLocks < ActiveRecord::Migration[6.1]
  def change
    remove_column :locks, :status, :boolean
  end
end
