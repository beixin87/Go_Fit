class GuidesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :create, :update, :destroy, :like, :dislike, :favorite]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_or_correct_user,   only: :destroy

  def index         
    if params[:search]
      if params[:type] == 'hits'
        @guides = Guide.search(params[:search]).order('hits DESC').paginate(page: params[:page], per_page: 8) 
      elsif params[:type] == 'like'  
        @guides = Guide.search(params[:search]).joins(:likeps).group('guides.id').order('COUNT(likeps.id) DESC').paginate(page: params[:page], per_page: 8)  
      elsif params[:type] == 'favo' 
        @guides = Guide.search(params[:search]).joins(:favorites).group('guides.id').where(:favorites => {:user_id => session[:user_id]}).paginate(page: params[:page], per_page: 8) 
      elsif params[:type] == 'mine' 
        @guides = Guide.search(params[:search]).where('user_id = ?', session[:user_id]).order('created_at DESC').paginate(page: params[:page], per_page: 8)     
      else   
        @guides = Guide.search(params[:search]).order('id DESC').paginate(page: params[:page], per_page: 8) 
      end   
    else
      if params[:type] == 'hits'
        @guides = Guide.order('hits DESC').paginate(page: params[:page], per_page: 8) 
      elsif params[:type] == 'like'
        @guides = Guide.joins(:likeps).group('guides.id').order('COUNT(likeps.id) DESC').paginate(page: params[:page], per_page: 8)
      elsif params[:type] == 'favo'
        @guides = Guide.joins(:favorites).group('guides.id').where(:favorites => {:user_id => session[:user_id]}).paginate(page: params[:page], per_page: 8)    
      elsif params[:type] == 'mine' 
        @guides = Guide.where('user_id = ?', session[:user_id]).order('created_at DESC').paginate(page: params[:page], per_page: 8)
      else 
        @guides = Guide.order('id DESC').paginate(page: params[:page], per_page: 8) 
      end
    end 

    if params[:type]
      @index_type = params[:type]
    else
      @index_type = 'norm'
    end   
       
    @guides_hi = Guide.order('hits DESC').limit(5) 
    @guides_li = Guide.joins(:likeps).group('guides.id').order('COUNT(likeps.id) DESC').limit(5)   
    @guides_fa = Guide.joins(:favorites).group('guides.id').where(:favorites => {:user_id => session[:user_id]}).limit(5)  
    @guides_my = Guide.where('user_id = ?', session[:user_id]).order('created_at DESC').limit(5)  
  end   
   
  def show    
    @guide = Guide.find(params[:id])
    if @guide.user_id != session[:user_id] 
      @guide.hits += 1 
      @guide.save 
    end 

    @now_likes = Likep.where('guide_id = ?', @guide.id).count
    @now_dislikes = Liken.where('guide_id = ?', @guide.id).count       
    @now_favorites = Favorite.where('guide_id = ? AND user_id = ?', @guide.id, session[:user_id]).count
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
    redirect_to :action => :info 
  end

  def info    
  end

  def like
    @guide = Guide.find(params[:id])
    @sum_likes = Likep.where('guide_id = ?', @guide.id).count
    @like_msg = ''    
    
    if @guide.user_id == session[:user_id] 
        @like_msg =   ' This is your guide'
    else 
      if Likep.where('guide_id = ? AND user_id = ?', @guide.id, session[:user_id]).exists?
        @like_msg =   ' You already liked'
      else   
        if @sum_likes == 0 
          @like_msg = ' User like this '
        else
          @like_msg = ' Users like this'
        end

        @likep = Likep.new
        @likep.guide_id = @guide.id
        @likep.user_id = session[:user_id]       
        @likep.save 
        @sum_likes += 1 
      end  
    end  

    if request.xhr?              
      @like_string = @sum_likes.to_s
      respond_to do |format| 
        format.js
      end  
    else      
      redirect_to @guide
    end   
  end

  def dislike   
    @guide = Guide.find(params[:id])
    @sum_dislikes = Liken.where('guide_id = ?', @guide.id).count
    @dislike_msg = ''    
    
    if @guide.user_id == session[:user_id] 
        @dislike_msg =   ' This is your guide'
    else 
      if Liken.where('guide_id = ? AND user_id = ?', @guide.id, session[:user_id]).exists?
        @dislike_msg =   ' You already disliked'
      else   
        if @sum_dislikes == 0 
          @dislike_msg = ' User dislike this '
        else
          @dislike_msg = ' Users dislike this'
        end

        @liken = Liken.new
        @liken.guide_id = @guide.id
        @liken.user_id = session[:user_id]       
        @liken.save 
        @sum_dislikes += 1 
      end  
    end  

    if request.xhr?              
      @dislike_string = @sum_dislikes.to_s
      respond_to do |format| 
        format.js
      end  
    else      
      redirect_to @guide
    end   
  end

  def favorite
    @guide = Guide.find(params[:id])
    @now_favorites = Favorite.where('guide_id = ? AND user_id = ?', @guide.id, session[:user_id]).count    
    if @now_favorites == 0
      @favorite = Favorite.new
      @favorite.guide_id = @guide.id   
      @favorite.user_id = session[:user_id]        
      @favorite.save  
      @favo_msg = 'NEW'   
    else   
      @favorite = Favorite.where('guide_id = ? AND user_id = ?', @guide.id, session[:user_id]).first
      @favorite.destroy      
      @favo_msg = 'DEL'
    end  
     
    if request.xhr?
      @favo_string = @favo_msg.to_s         
      respond_to do |format| 
        format.js
      end  
    else      
      redirect_to @guide
    end   
  end


  private

    def guide_params
      params.require(:guide).permit(:title, :content)
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
      redirect_to(root_url) unless Guide.find(params[:id]).user_id == current_user.id 
    end

    # Confirms an admin or correct user.
    def admin_or_correct_user
      redirect_to(root_url) unless (Guide.find(params[:id]).user_id == current_user.id  || current_user.admin?)
    end

end
