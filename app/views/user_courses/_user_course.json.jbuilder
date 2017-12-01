json.extract! user_course, :id, :user_id, :course_id, :created_at, :updated_at
json.url user_course_url(user_course, format: :json)
