json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :name
  json.url ingredient_url(ingredient, format: :json)
  json.association_type_id params[:association_type_id] if params[:association_type_id]
end
