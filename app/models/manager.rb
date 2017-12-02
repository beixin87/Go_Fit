class Manager < User
  has_many :gyms, foreign_key: "user_id", :dependent => :destroy

end
