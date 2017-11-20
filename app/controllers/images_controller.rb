class ImagesController < ApplicationController
 # protect_from_forgery except: :create
 
  def create
  	puts "start1" 
  	puts image_params
  	@image = Image.new(image_params)
  	puts "start2" 
    if @image.save
    	puts "saved"
    else
    	puts "error"
    end 
    puts "start3" 
    respond_to do |format|
      format.json { render :json => { url: Refile.attachment_url(@image, :image), image_id: @image.image_id } }
    end
  end
 
  def destroy
    @image = Image.find_by(image_id: params[:id])
    @image.destroy
    respond_to do |format|
      format.json { render :json => { status: :ok } }
    end
  end
  
  private
 
  def image_params
    params.require(:image).permit(:image)
  end
end
