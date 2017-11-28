class Course < ActiveRecord::Base
  has_many :user_courses
  has_many :users, through: :user_courses

  def can_add_student?(course_id)
    under_course_limit?(course_id) && !student_already_added?(user_id)

  end

  def under_course_limit?(course_id)
    course = Course.find(course_id )
    (user_courses.count < course.limit)
  end

  def student_already_added?(user_id)
    student = User.find(user_id)


    user_courses.where(user_id: student.id).exists?
  end
end
