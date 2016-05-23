class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_authentication
    flash[:danger] = 'Access to this page has been restricted. Please login first!'
    redirect_to login_path unless session[:user_id]
  end
end
