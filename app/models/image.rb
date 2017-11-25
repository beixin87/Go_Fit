class Image < ActiveRecord::Base
  attachment :image
  belongs_to :guide	
end
