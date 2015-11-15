FactoryGirl.define do
  factory :workout do
    name 'Default Workout Factory Name'
    description 'Default Workout Factory Description'

    factory :workout_with_exercises do
      after(:create) do |workout|
        workout.exercises << FactoryGirl.create(:exercise)
        # workout.exercises << FactoryGirl.create(:exercise)
        # workout.exercises << [
        # create(:exercise, name: 'Bench Press', workout_exercise: workout),
        # create(:exercise, name: 'Pushups', workout_exercise: workout),
        # create(:exercise, name: 'DB Flys', workout_exercise: workout)
        # ]
      end
    end
  end
end
