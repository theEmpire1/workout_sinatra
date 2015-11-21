Bundler.require
require 'sinatra/activerecord/rake'
require_all 'app'

namespace :db do
  task :load_config do
    require './app/workout_app'
  end
end
