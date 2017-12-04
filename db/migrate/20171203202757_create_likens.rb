class CreateLikens < ActiveRecord::Migration
  def change
    create_table :likens do |t|
      t.integer :user_id
      t.integer :guide_id

      t.timestamps null: false
    end
  end
end
