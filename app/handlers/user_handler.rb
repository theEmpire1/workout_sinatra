class UserHandler < WorkoutBase
  post '/new_account' do
    begin
      user_params = required_params(params, :name, :email, :password, :password_confirmation)
      new_user = User.new(user_params)
      new_user.save!
    rescue ArgumentError, ActiveRecord::RecordInvalid => e
      status 400
      body "#{e}"
    end
  end

  get '/workouts_for_user' do
    check_authentication
    begin
      required = required_params(params, :user_id)
      user_id = required[:user_id]
      user = User.find(user_id)
      workouts = user.workouts
    rescue ArgumentError, ActiveRecord::RecordNotFound => e
      body "#{e}"
      halt 400
    end
    jbuilder :workouts_for_user, locals: { workouts: workouts }
  end
end
