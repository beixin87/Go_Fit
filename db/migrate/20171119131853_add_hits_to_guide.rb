class AddHitsToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :hits, :integer
    add_column :guides, :user_name, :string
  end
end
