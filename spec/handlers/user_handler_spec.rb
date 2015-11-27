require_relative '../spec_helper'

def app
  WorkoutApp
end

describe WorkoutApp do
  describe '/user/new' do
    it 'creates a new user given valid params' do
      user_params = FactoryGirl.attributes_for(:user)
      expect do
        post '/user/new', user_params
      end.to change { User.all.count }.by(1)
    end

    it 'returns bad request if missing required parameter' do
      user_params = FactoryGirl.attributes_for(:user).except(:email)
      post '/user/new', user_params
      expect(last_response.status).to eq(400)
      expect(last_response.body).to include("Missing required parameter 'email'")
    end

    it 'returns bad request if password does not match confirmation' do
      user_params = FactoryGirl.attributes_for(:user, password_confirmation: 'bad')
      post '/user/new', user_params
      expect(last_response.status).to eq(400)
      expect(last_response.body).to include("Password confirmation doesn't match Password")
    end
  end

  describe '/user/workouts' do
    it 'returns all workouts for a given user' do
      user = FactoryGirl.create(:user_with_workouts)
      login_as user
      get '/user/workouts', user_id: user.id
      expected_name = user.workouts.first.name
      workouts_returned = JSON.parse(last_response.body)['workouts_for_user']
      expect(last_response.status).to eq(200)
      expect(workouts_returned.size).to eq(3)
      expect(workouts_returned.first['name']).to eq(expected_name)
    end

    it 'requires you to be logged in to request workouts' do
      user = FactoryGirl.create(:user)
      get '/user/workouts', user_id: user.id
      expect(last_response.status).to eq(401)
    end

    it 'returns correct message if user does not exist' do
      user = FactoryGirl.create(:user)
      login_as user
      get 'user/workouts', user_id: TestHelpers.invalid_user_id
      expect(last_response.status).to eq(400)
      expect(last_response.body).to include("Couldn't find User with 'id'=#{TestHelpers.invalid_user_id}")
    end

    it 'returns 200 and empty array if user has no workouts' do
      user = FactoryGirl.create(:user)
      login_as user
      get '/user/workouts', user_id: user.id
      expect(last_response.status).to eq(200)
    end
  end
end
