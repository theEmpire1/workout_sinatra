FactoryGirl.define do
  factory :workout do
    name 'Default Workout Factory Name'
    description 'Default Workout Factory Description'

    factory :workout_with_exercises do
      after(:create) do |workout|
        workout.exercises << [
          create(:exercise, name: 'Bench Press'),
          create(:exercise, name: 'Pushups'),
          create(:exercise, name: 'DB Flys')
        ]
      end
    end
  end
end
