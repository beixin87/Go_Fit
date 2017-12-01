class Gym < ActiveRecord::Base
  belongs_to :manager
  has_many :students
  has_many :instructors

  def initialize(attributes = {}) #Call when we execute User.new
    super
    @name  = attributes[:name]
    @email = attributes[:address]
    @description = attributes[:description]
  end


end
