class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  def student_already_added?(user_id)
    student = User.find(user_id)
    user_courses.where(user_id: student.id).exists?
  end
end
