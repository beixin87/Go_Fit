class Manager < User
  has_many :gyms, foreign_key: "user_id", :dependent => :destroy
  has_many :instructors
end
