json.array!(@movies) do |movie|
  json.extract! movie, :id, :tags
  json.url movie_url(movie, format: :json)
end
