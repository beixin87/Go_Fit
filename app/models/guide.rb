class Guide < ActiveRecord::Base
  belongs_to :user
  has_many :images
  validates :title, presence: true
  validates :content, presence: true
def self.search(search)
  where("title LIKE ?", "%#{search}%") 
  where("content LIKE ?", "%#{search}%")
  where("guide.user_name LIKE ?", "%#{search}%")
end
end
