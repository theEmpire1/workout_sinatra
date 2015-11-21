module Handlers
  module WorkoutHandler
    WorkoutApp.get '/workouts' do
      check_authentication
      'Hello World!'
    end

    WorkoutApp.get '/exercises_for_workout' do
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
end
