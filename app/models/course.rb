class Course < ActiveRecord::Base
  has_many :user_courses
  has_many :users, through: :user_courses

  validates :name, presence: true
  validates :user_id, presence: true
  validates :limit, presence: true
  validates :fee, presence: true
  validates :numberofenrolled, presence: true
  validates :start, presence: true
  validates :end, presence: true


  def student_already_added?(user_id)
    student = User.find(user_id)
    user_courses.where(user_id: student.id).exists?
  end

  def under_course_limit?
    user_courses.count < limit
  end


  def can_add_student?(user_id)
    under_course_limit? && !student_already_added?(user_id)
  end

end
