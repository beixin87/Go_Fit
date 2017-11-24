json.extract! course, :id, :name, :instructor_id, :limit, :start_time, :end_time, :fee, :created_at, :updated_at, :number_of_enrolled
json.url course_url(course, format: :json)
