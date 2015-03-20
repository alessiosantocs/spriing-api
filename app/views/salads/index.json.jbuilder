json.array!(@salads) do |salad|
  json.extract! salad, :id, :name
  json.url salad_url(salad, format: :json)
end
