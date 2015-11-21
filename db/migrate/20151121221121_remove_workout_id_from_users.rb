class RemoveWorkoutIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :workout_id
  end
end
