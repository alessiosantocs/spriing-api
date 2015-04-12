json.array!(@salads) do |salad|
  json.extract! salad, :id, :name
  json.ingredients salad.ingredients do |ingredient|
    json.extract! ingredient, :id, :name
    json.association_type ingredient.association_type(salad), :id, :name
  end
  json.url salad_url(salad, format: :json)
end
