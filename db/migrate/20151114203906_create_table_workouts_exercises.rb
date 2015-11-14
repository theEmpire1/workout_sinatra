class CreateTableWorkoutsExercises < ActiveRecord::Migration
  def change
    create_table :workouts_exercises do |t|
      t.belongs_to :workouts, index: true
      t.belongs_to :exercises, index: true
    end
  end
end
