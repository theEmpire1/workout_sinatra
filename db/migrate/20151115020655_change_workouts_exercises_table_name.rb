class ChangeWorkoutsExercisesTableName < ActiveRecord::Migration
  def change
    rename_table :workouts_exercises, :workout_exercises
  end
end
