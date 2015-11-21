module Handlers
  module UserHandler
    WorkoutApp.post '/new_account' do
      begin
        user_params = required_params(params, :name, :email, :password, :password_confirmation)
        new_user = User.new(user_params)
        new_user.save!
      rescue ArgumentError, ActiveRecord::RecordInvalid => e
        status 400
        body "#{e}"
      end
    end
  end
end
