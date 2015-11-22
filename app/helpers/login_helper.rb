module LoginHelper
  def warden_handler
    env['warden']
  end

  def confirm_user_change(user_id)
    return unless user_id.to_i != current_user.id
    body 'Cannot create workout for other users'
    halt 401
  end

  def current_user
    warden_handler.user
  end

  def check_authentication
    return if warden_handler.authenticated?
    body 'User not authenticated'
    halt 401
  end
end
