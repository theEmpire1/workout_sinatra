require_relative '../spec_helper'

describe WorkoutApp do
  def app
    WorkoutApp
  end

  describe 'logging in users' do
    after :each do
      logout
    end

    it 'does not allow me to request workouts unless I am logged in' do
      workout = FactoryGirl.create(:workout_with_exercises)
      get '/exercises_for_workout', workout_id: workout.id
      expect(last_response).to be_unauthorized
    end

    it 'allows me to request workouts when I am logged in' do
      user = FactoryGirl.create(:user)
      login_as(user)
      workout = FactoryGirl.create(:workout_with_exercises)
      get '/exercises_for_workout', workout_id: workout.id
      expect(last_response.status).to eq(200)
    end

    it 'does not allow me to request workouts unless logged in' do
      workout = FactoryGirl.create(:workout_with_exercises)
      get '/exercises_for_workout', workout_id: workout.id
      expect(last_response.status).to eq(401)
    end

    it 'authenticates a user' do
      FactoryGirl.create(:user)
      post '/session', email: 'joe.shmoe@email.com', password: 'shmoebaby'
      expect(last_response.status).to eq(200)
    end

    it 'responds with 401 unauthorized for incorrect password' do
      FactoryGirl.create(:user)
      post '/session', email: 'joe.shmoe@email.com', password: 'incorrect'
      expect(last_response).to be_unauthorized
    end
  end
end
