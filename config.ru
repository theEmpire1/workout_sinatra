require 'rubygems'
require 'bundler'

Bundler.require

ENV['APP_NAME'] = 'workout'

require_all 'app'

# ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV['DEBUG']
#
# WorkoutApp.enable :logging

run WorkoutApp
