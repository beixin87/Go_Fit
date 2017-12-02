class GymsController < ApplicationController
  before_action :logged_in_user, only: [:index]
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
      if User.where(:id => @gym.user_id).present?
        @manager = User.find(@gym.user_id)
        if @manager.type == 'Manager'
          # Handle a successful save.
          if @gym.save
            flash[:success] = "Gym was successfully created."
            @manager = User.find(@gym.user_id)
            @manager.gyms << @gym
            redirect_to @gym
          end
        else
          flash[:danger] = "Assigned user is not a Manager."
          render 'new'
        end
      else
        flash[:danger] = "Assigned user does not exist."
        render 'new'
      end
    end

    def edit
      @gym = Gym.find(params[:id])
    end

    def update
      @gym = Gym.find(params[:id])
      if current_user.admin?
        if User.where(:id => gym_params[:user_id]).present?
          @manager = User.find(gym_params[:user_id])
          if @manager.type == 'Manager'
            if @gym.update(gym_params)
              # Handle a successful update.
              flash[:success] = "Gym was successfully updated."
              redirect_to @gym
            end
          else
            flash[:danger] = "Assigned user is not a Manager."
            render 'edit'
          end
        else
          flash[:danger] = "Assigned user does not exist."
          render 'edit'
        end
      else
        if @gym.update(gym_params)
          # Handle a successful update.
          flash[:success] = "Gym was successfully updated."
          redirect_to @gym
        end
      end
    end

    def destroy
      Gym.find(params[:id]).destroy
      flash[:success] = "Gym deleted"
      redirect_to gyms_url
    end

    private

        def gym_params
          if(current_user.admin?)
            params.require(:gym).permit(:name, :address, :description, :user_id)

          else
            params.require(:gym).permit(:name, :address, :description)
          end
        end

        def correct_user
          @gym = Gym.find(params[:id])
          @user = User.find(@gym.user_id)
          redirect_to root_url unless (@user == current_user || current_user.admin?)
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
