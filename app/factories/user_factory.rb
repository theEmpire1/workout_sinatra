FactoryGirl.define do
  factory :user do
    name 'Joe'
    email 'joe.shmoe@email.com'
    password 'shmoebaby'
    password_confirmation 'shmoebaby'
  end
end
