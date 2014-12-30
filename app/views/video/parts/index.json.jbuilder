json.array!(@video_parts) do |video_part|
  json.extract! video_part, :id, :title, :description, :body, :tags, :status, :slug, :language, :order
  json.url video_lesson_part_url(id:video_part.id, lesson_id:video_part.video_lesson_id, format: :json)
end
