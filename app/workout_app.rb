require 'sinatra/jbuilder'
require 'sinatra/activerecord'

class WorkoutApp < WorkoutBase
  # disable :show_exceptions

  register Sinatra::ActiveRecordExtension

  use LoginHandler
  use WorkoutHandler
  use UserHandler
  use ExerciseHandler

  set :database_file, '../config/database.yml'
end
