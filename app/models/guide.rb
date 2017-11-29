class Guide < ActiveRecord::Base
  belongs_to :user
  has_many :images
  validates :title, presence: true
  validates :content, presence: true
end
