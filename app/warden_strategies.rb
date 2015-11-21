module WardenStrategies
  Warden::Strategies.add(:password) do
    def valid?
      params['email'] || params['password']
    end

    def authenticate!
      user = User.find_by(email: params['email'])
      if user && user.authenticate(params['password'])
        success!(user)
      else
        fail!('Could not log in')
      end
    end
  end
end
