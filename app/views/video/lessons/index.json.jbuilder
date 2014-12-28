json.array!(@video_lessons) do |video_lesson|
  json.extract! video_lesson, :id, :title, :description, :image, :tags, :order
  json.url video_lesson_url(video_lesson, format: :json)
end
