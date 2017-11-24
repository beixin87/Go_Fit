class SessionsController < ApplicationController
before_filter :redirect_if_logged_in, :except=>[:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_by_user_type
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

private

  def redirect_if_logged_in
    if logged_in?
      redirect_by_user_type
    else
    end
  end

  def redirect_by_user_type
    if current_user.admin?
        redirect_to :controller => "users", :action => "index"
    else
      redirect_to current_user
    end
  end

end
