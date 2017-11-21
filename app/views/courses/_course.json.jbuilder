json.extract! course, :id, :name, :instructor_id, :limit, :fee, :created_at, :updated_at
json.url course_url(course, format: :json)
