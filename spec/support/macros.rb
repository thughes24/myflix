def set_user_and_session
  user = Fabricate(:user)
  session[:user_id] = user.id
end

def clear_session
  session[:user_id] = nil
end