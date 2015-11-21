class AddWorkoutAssociationToUser < ActiveRecord::Migration
  def change
    add_column :users, :workout_id, :integer
    add_index :users, :workout_id
  end
end
