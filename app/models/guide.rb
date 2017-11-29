class Guide < ActiveRecord::Base
  belongs_to :user 
  has_many :images
<<<<<<< HEAD
=======
  validates :title, presence: true
  validates :content, presence: true
>>>>>>> e7629e842362b2a3c50fe57c5ff68ca01c3f3242
end
