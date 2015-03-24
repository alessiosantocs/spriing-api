# {
  # ingredients: {}
  json.ingredients do
    # suggested: []
    json.suggested(@suggested_ingredients) do |ingredient|
      json.extract! ingredient, :id, :name
      json.url ingredient_url(ingredient, format: :json)
      json.association_type_id @association_type.id
    end

    json.association_type(@association_type, :id, :name)
  end
# }
