class AddCoordinatesToLock < ActiveRecord::Migration[6.1]
  def change
    add_column :locks, :latitude, :float
    add_column :locks, :longitude, :float
  end
end
