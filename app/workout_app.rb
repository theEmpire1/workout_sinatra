require 'sinatra'
require 'sinatra/activerecord'

class WorkoutApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :database_file, '../config/database.yml'

  get '/workouts' do
    'Hello World!'
  end
end
