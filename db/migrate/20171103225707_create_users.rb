class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
<<<<<<< HEAD
      t.string :name
      t.string :email

=======
	    
      t.string :email
      t.string :password
      t.string :encrypted_password
      t.string :salt
     
>>>>>>> 6d5f3bd2247e195cc76b838f4bdeb7cee53ef8cc
      t.timestamps
    end
  end
end
