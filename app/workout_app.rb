require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/jbuilder'

class WorkoutApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  disable :show_exceptions

  set :database_file, '../config/database.yml'

  get '/workouts' do
    'Hello World!'
  end

  get '/exercises_for_workout' do
    workout_id = params[:workout_id].to_i
    begin
      exercises = Workout.find_by(id: workout_id).exercises
    rescue
      render json: 'record not found'
    end
    jbuilder :exercises_for_workout, locals: { exercises: exercises }
  end
end
