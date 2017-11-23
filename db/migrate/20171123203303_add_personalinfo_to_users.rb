class AddPersonalinfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :height, :float
    add_column :users, :weight, :float
    add_column :users, :date_of_birth, :date
    add_column :users, :description, :text
  end
end
