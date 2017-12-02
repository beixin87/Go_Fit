class GymsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :new, :create, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:new, :create, :destroy]

    def index
        @gyms = Gym.all
    end

    def show
      @gym = Gym.find(params[:id])
      # debugger  << uncomment to see debug in terminal
    end

    def new
      @gym = Gym.new
    end

    def create
      @gym = Gym.new(gym_params)
      if @gym.save
        # Handle a successful save.
        flash[:success] = "Gym was successfully created."
        @manager = User.find(@gym.user_id)
        @manager.gym << @gym
        redirect_to @gym
      else
        render 'new'
      end
    end

    def edit
      @gym = Gym.find(params[:id])
    end

    def update
      @gym = Gym.find(params[:id])
      if @gym.update(gym_params)
        # Handle a successful update.
        flash[:success] = "Gym was successfully updated."
        redirect_to @gym
      else
        render 'edit'
      end
    end

    def destroy
      Gym.find(params[:id]).destroy
      flash[:success] = "Gym deleted"
      redirect_to courses_url
    end

    private

        def gym_params
          params.require(:gym).permit(:name, :address, :description, :user_id)
        end

        def correct_user
          @gym = Gym.find(params[:id])
          @user = User.find(@gym.user_id)
          redirect_to root_url unless @user == current_user
        end

        def logged_in_user
          unless logged_in?
            flash[:danger] = "Please log in."
            redirect_to login_url
          end
        end

        def manager_user
          redirect_to(root_url) unless current_user.type == "Manager"
        end

        def admin_user
          redirect_to(root_url) unless current_user.admin?
        end

end
