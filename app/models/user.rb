class User < ActiveRecord::Base
  #attr_accessor :name, :email (causes nil attributes)

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50}  #Used to check empty

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length: { maximum:255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  def initialize(attributes = {}) #Call when we execute User.new
    super
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end

  has_secure_password
  validates :password, length: { minimum: 6 }

end
