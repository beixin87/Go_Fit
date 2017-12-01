class Gym < ActiveRecord::Base
  belongs_to :manager
  has_many :students
  has_many :instructors
end
