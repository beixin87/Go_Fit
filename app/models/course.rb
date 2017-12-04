class Course < ActiveRecord::Base
  has_many :user_courses
  has_many :users, through: :user_courses
  belongs_to :gym

  validates :name, presence: true, length: { maximum: 50}



  validates :limit, presence: true,numericality: { greater_than: 5,
                     less_than: 20,
                     :allow_nil => false}

  validates :fee, presence: true,numericality: { greater_than: 0,
                     less_than: 10000,
                     :allow_nil => false}

  validates :start, presence: true, :date => {:after => Proc.new { Time.now },
                                      :before => Proc.new { Time.now + 1.month}}

  validates :class_hour, presence: true ,numericality: { greater_than: 1,
                     less_than: 3,
                     :allow_nil => false}

  def start_time
    start
  end

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
