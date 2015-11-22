require_relative '../spec_helper'

describe WorkoutApp do
  def app
    WorkoutApp
  end

  describe '/exercises' do
    it 'lists all exercises' do
      user = FactoryGirl.create(:user)
      login_as user
      FactoryGirl.create_list(:exercise, 3)
      get '/exercises'
      returned = JSON.parse(last_response.body)['exercises']
      expect(last_response.status).to eq(200)
      expect(returned.size).to eq(3)
    end

    it 'requires a user to be logged in' do
      FactoryGirl.create(:exercise)
      get '/exercises'
      expect(last_response.status).to eq(401)
    end
  end
end
