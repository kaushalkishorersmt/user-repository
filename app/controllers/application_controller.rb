class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    session[:user_id].nil? ? nil : User.find(session[:user_id])
  end

  def after_sign_in_path_for(resource)
    repositories_index_path
  end

end
