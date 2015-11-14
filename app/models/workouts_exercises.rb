class WorkoutsExercises < ActiveRecord::Base
  belongs_to :workouts
  belongs_to :exercises
end
