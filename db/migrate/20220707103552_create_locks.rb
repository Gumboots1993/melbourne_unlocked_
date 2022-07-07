class CreateLocks < ActiveRecord::Migration[6.1]
  def change
    create_table :locks do |t|
      t.text :address
      t.text :description
      t.text :image
      t.text :special_content
      t.text :lock_type
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
