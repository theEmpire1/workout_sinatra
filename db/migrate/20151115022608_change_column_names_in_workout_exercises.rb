class ChangeColumnNamesInWorkoutExercises < ActiveRecord::Migration
  def change
    rename_column :workout_exercises, :workouts_id, :workout_id
    rename_column :workout_exercises, :exercises_id, :exercise_id
  end
end
