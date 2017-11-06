class SessionsController < ApplicationController
  before_filter :authenticate_user, :except => [:index, :login, :login_attempt, :logout, :create, :home, :profile, :setting ]
	before_filter :save_login_state, :only => [:index, :login, :login_attempt, :create, :home, :profile, :setting]
  def home
    #Home Page
  end

  def profile
    current_user
    #Profile Page
  end

  def setting
    current_user
    #Setting Page
  end

  def login
    #Login Form
  end

  def create
     
    authorized_user = User.authenticate(params[:email],params[:password])
    if authorized_user
      log_in  authorized_user  
      if authorized_user.admin
        flash[:notice] = "Welcome #{authorized_user.email}, you logged in as Administrator"
        redirect_to(:action => 'setting') 
      else        
        flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.email}"
        redirect_to(:action => 'profile')
      end        
    else
      flash[:notice] = 'Invalid email/password!!' 
      flash[:color] = "invalid"    
      render 'login' 
    end

  end


  def login_attempt
  authorized_user = User.authenticate(params[:email],params[:password])
  if authorized_user
    session[:user_id] = authorized_user.id
    flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.email}"
    redirect_to(:action => 'home')     
  else
    flash[:notice] = "Invalid Username or Password"
    flash[:color]= "invalid"
    render "login"
  end
  end

  def logout
    #log_out
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
