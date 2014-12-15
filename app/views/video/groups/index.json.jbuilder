json.array!(@video_groups) do |video_group|
  json.extract! video_group, :id, :value, :tags
  json.url video_group_url(video_group, format: :json)
end
