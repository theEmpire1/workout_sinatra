require 'sinatra/activerecord'
require 'sinatra/jbuilder'
require 'sinatra/base'

class WorkoutApp < Sinatra::Base
  set :database_file, '../config/database.yml'
  disable :show_exceptions

  register Sinatra::ActiveRecordExtension
  register Handlers::SessionHandler
  register Handlers::UserHandler
  register Handlers::WorkoutHandler
  register WardenStrategies

  helpers SessionHelper
  helpers HashHelpers

  use Rack::Session::Cookie
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

  get '/' do
    'whoops'
  end
end
