require_relative '../spec_helper'

describe WorkoutApp do
  def app
    WorkoutApp
  end

  describe '/workout/exercises' do
    it 'returns all exercises for a given workout' do
      user = FactoryGirl.create(:user)
      login_as user
      workout = FactoryGirl.create(:workout_with_exercises)
      exercise_ids = workout.exercises.each_with_object([]) do |e, arr|
        arr << e.id
      end

      expected_exercise_response = {
        exercises_for_workout: [
          {
            id: exercise_ids[0],
            name: 'Bench Press',
            description: 'Default Exercise Factory Description'
          },
          {
            id: exercise_ids[1],
            name: 'Pushups',
            description: 'Default Exercise Factory Description'
          },
          {
            id: exercise_ids[2],
            name: 'DB Flys',
            description: 'Default Exercise Factory Description'
          }
        ]
      }

      get 'workout/exercises', workout_id: workout.id.to_int
      expect(last_response.errors).to eq('')
      expect(JSON.parse(last_response.body)).to eq(JSON.parse(expected_exercise_response.to_json))
    end
  end

  describe '/workout/create' do
    it 'creates a workout when given correct parameters' do
      user = FactoryGirl.create(:user)
      login_as user
      workout_params = {
        name: 'Swimming',
        description: 'This is my version of cardio',
        user_id: user.id
      }
      expect do
        post '/workout/create', workout_params
      end.to change { user.workouts.count }.by(1)
      expect(last_response.status).to eq(200)
    end

    it 'requires a user to be logged in' do
      user = FactoryGirl.create(:user)
      workout_params = {
        name: 'Swimming',
        description: 'This is my version of cardio',
        user_id: user.id
      }
      post '/workout/create', workout_params
      expect(last_response.status).to eq(401)
    end

    it 'does not allow a logged in user to create a workout for anyone but themselves' do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:another_user)
      login_as user1
      workout_params = {
        name: 'Swimming',
        description: 'This is my version of cardio',
        user_id: user2.id
      }
      post '/workout/create', workout_params
      expect(last_response.status).to eq(401)
      expect(last_response.body).to include('Cannot create workout for other users')
    end
  end
end
