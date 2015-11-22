require 'sinatra/activerecord'
require 'sinatra/jbuilder'
require 'sinatra/base'

class WorkoutApp < Sinatra::Base
  disable :show_exceptions

  register Sinatra::ActiveRecordExtension
  register Handlers::LoginHandler
  register Handlers::UserHandler
  register Handlers::WorkoutHandler
  register Handlers::ExerciseHandler
  register WardenStrategies

  helpers LoginHelper
  helpers HashHelpers

  use Rack::Session::Cookie
  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.intercept_401 = false
    manager.failure_app = WorkoutApp
    manager.serialize_into_session(&:id)
    manager.serialize_from_session { |id| User.find(id) }
  end
  set :database_file, '../config/database.yml'

  Warden::Manager.before_failure do |env, _opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  get '/' do
    'whoops'
  end
end
