class Guide < ActiveRecord::Base
  belongs_to :user
  has_many :images
  def self.search(search)
  	where("content ILIKE ?", "%#{search}%")
  	where("title ILIKE ?", "%#{search}%")
  end 
  validates :title, presence: true
  validates :content, presence: true	 
end
