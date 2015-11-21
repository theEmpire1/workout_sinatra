module LoginHelper
  def warden_handler
    env['warden']
  end

  def current_user
    warden_handler.user
  end

  def check_authentication
    halt 401 unless warden_handler.authenticated?
  end
end
