class AddUserIdToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :user_id, :integer
    add_index :gyms, :user_id
  end
end
