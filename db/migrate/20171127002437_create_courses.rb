class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.references :user, index: true
      t.integer :limit
      t.decimal :fee
      t.integer :numberofenrolled
      t.datetime :start
      t.datetime :end

      t.timestamps null: false
    end
    add_foreign_key :courses, :users
  end
end
