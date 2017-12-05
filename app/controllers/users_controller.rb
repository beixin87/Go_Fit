class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :mycourses]
  #before_action :correct_user,   only: [:edit, :update, :mycourses]
  before_action :admin_user,     only: [:index, :destroy]




  def index
      @userCnt = User.all.count
      #@users = User.order('id DESC').paginate(page: params[:page], per_page: 10)
      @users = User.all.paginate(page: params[:page], per_page: 5)

  end


  def show
    @user = User.find(params[:id])
    # debugger  << uncomment to see debug in terminal
    @user_courses = @user.user_courses
    @mycourses = @user.courses
  end

  def mycourses
    @user =  User.find(params[:id])
    @user_courses = @user.user_courses
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

      def user_params
        if params.has_key? :manager
          params[:user] = params.delete :manager
        elsif params.has_key? :student
          params[:user] = params.delete :student
        elsif params.has_key? :instructor
          params[:user] = params.delete :instructor
        end
            
          params.require(:user).permit(:name, :email, :password,
                                       :password_confirmation, :height,
                                       :weight, :description, :date_of_birth , :type)
      end

      # Confirms a logged-in user.
      def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end

      # Confirms the correct user.
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      end

      # Confirms an admin user.
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end

      def manager_user
        redirect_to(root_url) unless current_user.type == "manager"
      end

      def instructor_user
        redirect_to(root_url) unless current_user.type == "instructor"
      end
end
