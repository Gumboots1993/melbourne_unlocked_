class ChangeAddressTypeOnLocks < ActiveRecord::Migration[6.1]
  def change
    change_column :locks, :address, :string
  end
end
