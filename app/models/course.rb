class Course < ActiveRecord::Base

  has_many :user_courses
  has_many :users, through: :user_courses
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :instructor_id, presence: true
  validates :limit, presence: true
  validates :fee, presence: true


end
