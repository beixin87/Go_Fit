class Gym < ActiveRecord::Base
  belongs_to :manager
  has_many :students
  has_many :instructors
  has_many :courses, :dependent => :destroy
  validates :user_id, presence: true
  validates :name, presence: true
  validates :address, presence: true, uniqueness: { case_sensitive: false }

  def initialize(attributes = {}) #Call when we execute User.new
    super
    @name  = attributes[:name]
    @email = attributes[:address]
    @description = attributes[:description]
  end



end
