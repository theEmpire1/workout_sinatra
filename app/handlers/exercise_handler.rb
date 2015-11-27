class ExerciseHandler < WorkoutBase
  namespace '/exercise' do
    get '/all' do
      check_authentication
      exercises = Exercise.all
      jbuilder :exercises, locals: { exercises: exercises }
    end
  end
end
