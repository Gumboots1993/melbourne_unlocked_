class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :locks, :image, :photo
  end
end
