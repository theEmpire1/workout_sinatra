require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/jbuilder'
require 'sinatra/base'

class WorkoutApp < Sinatra::Base
  helpers SessionHelper
  helpers HashHelpers
  use Rack::Session::Cookie
  register Sinatra::ActiveRecordExtension
  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.intercept_401 = false
    manager.failure_app = WorkoutApp
    manager.serialize_into_session { |user| user.id }
    manager.serialize_from_session { |id| User.find(id) }
  end

  Warden::Manager.before_failure do |env, _opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['email'] || params['password']
    end

    def authenticate!
      user = User.find_by(email: params['email'])
      if user && user.authenticate(params['password'])
        success!(user)
      else
        fail!('Could not log in')
      end
    end
  end

  disable :show_exceptions

  set :database_file, '../config/database.yml'

  post '/session' do
    warden_handler.authenticate!
    if warden_handler.authenticated?
      halt 200
    else
      status 401
    end
  end

  post '/unauthenticated' do
    status 401
  end

  get '/' do
    'whoops'
  end

  post '/new_account' do
    begin
      user_params = required_params(params, :name, :email, :password, :password_confirmation)
      new_user = User.new(user_params)
      new_user.save!
    rescue ArgumentError, ActiveRecord::RecordInvalid => e
      status 400
      body "#{e}"
    end
  end

  get '/workouts' do
    check_authentication
    'Hello World!'
  end

  get '/exercises_for_workout' do
    check_authentication
    workout_id = params[:workout_id].to_i
    begin
      exercises = Workout.find_by(id: workout_id).exercises
    rescue
      render json: 'record not found'
    end
    jbuilder :exercises_for_workout, locals: { exercises: exercises }
  end
end
