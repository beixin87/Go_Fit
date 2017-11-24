class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :instructor_id
      t.integer :limit
      t.integer :number_of_enrolled
      t.integer :fee
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
