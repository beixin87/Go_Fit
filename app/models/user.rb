class User < ActiveRecord::Base
  #attr_accessor :name, :email (causes nil attributes)
  attr_accessor :remember_token


  has_many :guides
  has_one :calculator

  has_many :guides

  has_many :user_courses
  has_many :courses, through: :user_courses

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50}  #Used to check empty

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :height, numericality: { greater_than: 60,
                     less_than: 300,
                     :allow_nil => true}
  validates :weight, numericality: {greater_than: 0,
                     less_than: 700,
                     :allow_nil => true}
  validates :date_of_birth, :date => {:after => Proc.new { Time.now - 120.years},
                                      :before => Proc.new { Time.now},
                                      :allow_blank => true}
  validates :type, inclusion: { in: %w(student, instructor, manager),
                                message: "%{value} is not a valid type" },
                                allow_nil: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :guides
  has_one :calculator
  def initialize(attributes = {}) #Call when we execute User.new
    super
    @name  = attributes[:name]
    @email = attributes[:email]
    @height = attributes[:height]
    @weight = attributes[:weight]
    @date_of_birth = attributes[:date_of_birth]
    @description = attributes[:description]
    @type = attributes[:type]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

end
