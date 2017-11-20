class SessionsController < ApplicationController
<<<<<<< HEAD

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      if current_user.admin?
          redirect_to :controller => "users", :action => "index"
      else
        redirect_to user
      end

    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
=======
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
>>>>>>> 6d5f3bd2247e195cc76b838f4bdeb7cee53ef8cc
  end
end
