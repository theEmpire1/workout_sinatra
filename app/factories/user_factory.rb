FactoryGirl.define do
  factory :user do
    name 'Joe'
    email 'joe.shmoe@email.com'
    password 'shmoebaby'
    password_confirmation 'shmoebaby'

    factory :user_with_workouts do
      after(:create) do |user|
        user.workouts << [
          create(:workout, name: 'Shoulders', description: 'Do shoulders on Monday'),
          create(:workout, name: 'Chest', description: 'Need to get bigger chest'),
          create(:workout, name: 'Cardio', description: 'Cut the fat')
        ]
      end
    end

    factory :another_user do
      name 'Bob'
      email 'bob@email.com'
      password 'bobisnumberone'
      password_confirmation 'bobisnumberone'
    end
  end
end
