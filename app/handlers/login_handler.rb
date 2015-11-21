module Handlers
  module LoginHandler
    WorkoutApp.post '/login' do
      warden_handler.authenticate!
      if warden_handler.authenticated?
        halt 200
      else
        status 401
      end
    end

    WorkoutApp.post '/unauthenticated' do
      status 401
    end
  end
end
