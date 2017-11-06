class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery  
  include SessionsHelper
  protected
  def authenticate_user
  	unless session[:email]
  		redirect_to(:controller => 'sessions', :action => 'login')
  		return false
  	else
      # set current_user by the current user object
      @current_user = User.find session[:email]
  		return true
  	end
  end
  def save_login_state
   if session[:email]
           redirect_to(:controller => 'sessions', :action => 'home')
     return false
   else
     return true
   end
  end
end
