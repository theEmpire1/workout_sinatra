class ChangeWorkoutsTableToExercises < ActiveRecord::Migration
  def change
    rename_table :workouts, :exercises
  end
end
