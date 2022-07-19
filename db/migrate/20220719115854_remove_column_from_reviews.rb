class RemoveColumnFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :reference_visit_id
  end
end
