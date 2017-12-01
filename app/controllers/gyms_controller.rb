class GymsController < ApplicationController

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
      @gym = Gym.new(gym_params)    # Not the final implementation!
      if @gym.save
        # Handle a successful save.
        flash[:success] = "Gym was successfully created."
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
          params.require(:gym).permit(:name, :address, :description)
        end

end
