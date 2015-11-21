require_relative '../spec_helper'

def app
  WorkoutApp
end

describe WorkoutApp do
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
