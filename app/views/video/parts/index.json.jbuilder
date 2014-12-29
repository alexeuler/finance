json.array!(@video_parts) do |video_part|
  json.extract! video_part, :id, :title, :description, :body, :tags, :status, :slug, :language, :order
  json.url video_part_url(video_part, format: :json)
end
