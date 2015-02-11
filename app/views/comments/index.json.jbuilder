json.array!(@comments) do |comment|
  json.extract! comment, :id, :text, :parent_id, :user_id, :category
  json.url comment_url(comment, format: :json)
end
