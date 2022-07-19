class AddStatusToLocks < ActiveRecord::Migration[6.1]
  def change
    add_column :locks, :status, :string, default: "Pending"
  end
end
