class WorkoutHandler < WorkoutBase
  get '/workouts' do
    check_authentication
    'Hello World!'
  end

  get '/exercises_for_workout' do
    check_authentication
    required = required_params(params, :workout_id)
    workout_id = required[:workout_id].to_i
    begin
      exercises = Workout.find_by(id: workout_id).exercises
    rescue
      render json: 'record not found'
    end
    jbuilder :exercises_for_workout, locals: { exercises: exercises }
  end

  post '/create_workout' do
    check_authentication
    begin
      required = required_params(params, :user_id, :name, :description)
      confirm_user_change(required[:user_id])
      workout = Workout.new(required)
      workout.save!
    rescue ArgumentError => e
      body "#{e}"
      halt 400
    end
    status 200
  end
end
