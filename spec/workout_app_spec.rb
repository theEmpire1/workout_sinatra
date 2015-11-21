require_relative 'spec_helper'

describe WorkoutApp do
  def app
    WorkoutApp
  end

  let(:joe) { FactoryGirl.build(:user) }

  before do
    login_as(joe)
  end

  after :each do
    logout
  end

  describe '/workouts' do
    it 'returns hello world' do
      get '/workouts'
      expect(last_response.status).to eq(200)
    end
  end

  describe '/exercises_for_workout' do
    it 'returns all exercises for a given workout' do
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

      get '/exercises_for_workout', workout_id: workout.id.to_int
      expect(JSON.parse(last_response.body)).to eq(JSON.parse(expected_exercise_response.to_json))
    end
  end

  describe '/new_account' do
    it 'creates a new user given valid params' do
      user_params = FactoryGirl.attributes_for(:user)
      expect do
        post '/new_account', user_params
      end.to change { User.all.count }.by(1)
    end

    it 'returns bad request if missing required parameter' do
      user_params = FactoryGirl.attributes_for(:user).except(:email)
      post '/new_account', user_params
      expect(last_response.status).to eq(400)
      expect(last_response.body).to include("Missing required parameter 'email'")
    end

    it 'returns bad request if password does not match confirmation' do
      user_params = FactoryGirl.attributes_for(:user, password_confirmation: 'bad')
      post '/new_account', user_params
      expect(last_response.status).to eq(400)
      expect(last_response.body).to include("Password confirmation doesn't match Password")
    end
  end
end
