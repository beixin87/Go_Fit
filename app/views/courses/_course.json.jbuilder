json.extract! course, :id, :user_id,:name, :limit, :fee, :numberofenrolled, :start, :end, :created_at, :updated_at
json.url course_url(course, format: :json)
