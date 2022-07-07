class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lock, null: false, foreign_key: true
      t.text :photo
      t.datetime :unlocked_date

      t.timestamps
    end
  end
end
