class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer[] :day_of_week
      t.time :time_of_day
      t.timerange :time_range
      t.text :recurring
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
