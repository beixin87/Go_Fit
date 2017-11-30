class Guide < ActiveRecord::Base
  belongs_to :user
  has_many :images
  validates :title, presence: true
  validates :content, presence: true
  def self.search(search)
  	where("content LIKE ?", "%#{search}%")
  	where("title LIKE ?", "%#{search}%") 
  	
  end
end
