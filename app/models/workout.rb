class Workout < ActiveRecord::Base
  has_many :workouts_exercises, dependent: :destroy
  has_many :exercises, through: :workouts_exercises
end
