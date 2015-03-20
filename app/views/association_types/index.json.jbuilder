json.array!(@association_types) do |association_type|
  json.extract! association_type, :id, :name
  json.url association_type_url(association_type, format: :json)
end
