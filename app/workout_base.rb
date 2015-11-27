require 'sinatra/base'
require 'sinatra/namespace'
require 'warden'
require_relative 'helpers/login_helpers'
require_relative 'helpers/hash_helpers'

class WorkoutBase < Sinatra::Base
  register WardenStrategies
  register Sinatra::Namespace
  helpers LoginHelpers, HashHelpers

  use Rack::Session::Cookie

  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.intercept_401 = false
    manager.failure_app = WorkoutApp
    manager.serialize_into_session(&:id)
    manager.serialize_from_session { |id| User.find(id) }
  end

  Warden::Manager.before_failure do |env, _opts|
    env['REQUEST_METHOD'] = 'POST'
  end
end
