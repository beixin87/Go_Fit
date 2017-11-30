class GuidesController < ApplicationController
   before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]


  def index         
      @totalCnt = Guide.all.count 
      @guides = Guide.order('id DESC').paginate(page: params[:page], per_page: 5)                  
  end


  def show    
    @guide = Guide.find(params[:id])
    if @guide.user_id != session[:user_id] 
      @guide.hits += 1 
      @guide.save 
    end   
  end

  def new  	
    @guide = Guide.new
  end
  
  def edit
    @guide = Guide.find(params[:id])
  end

  def create
    @guide = Guide.new(guide_params)
    @guide.user_id = session[:user_id]
    @guide.user_name  = User.find(session[:user_id]).name 
    @guide.hits = 0
       
    if @guide.save        
      flash[:success] = "Success Make New Guide"
      redirect_to @guide
    else
      render 'new'
    end
  end

  def update
    @guide = Guide.find(params[:id])
    if @guide.update_attributes(guide_params)      
      flash[:success] = "Guide updated"
      redirect_to @guide
    else
      render 'edit'
    end
  end

  def destroy
    Guide.find(params[:id]).destroy
    flash[:success] = "Your Guide deleted"
    redirect_to guides_url
  end

  private

    def guide_params
      params.require(:guide).permit(:title, :content)
    end
     
     def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
end
