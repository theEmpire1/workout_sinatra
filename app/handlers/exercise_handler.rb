module Handlers
  module ExerciseHandler
    WorkoutApp.get '/exercises' do
      check_authentication
      exercises = Exercise.all
      jbuilder :exercises, locals: { exercises: exercises }
    end
  end
end
