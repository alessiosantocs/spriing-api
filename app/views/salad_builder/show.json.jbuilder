# {
  # ingredients: {}
  json.ingredients(@suggested_ingredients) do |ingredient|
    json.extract! ingredient, :id, :name
    json.url ingredient_url(ingredient, format: :json)
    json.association_type @association_type, :id, :name
  end
  json.association_type(@association_type, :id, :name)
# }
