class CreateLikeps < ActiveRecord::Migration
  def change
    create_table :likeps do |t|
      t.integer :user_id
      t.integer :guide_id

      t.timestamps null: false
    end
  end
end
