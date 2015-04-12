
class Salad < ActiveRecord::Base

  # Salas < IngredientsAssociations > Ingredients

  has_many :ingredients_associations, dependent: :destroy
  has_many :ingredients, through: :ingredients_associations

  # A user can favorite a salad to save it
  has_many :favorites

  belongs_to :user # Through user_id. This is optional


  scope :with_ingredients, lambda { |ingredients_array|
    includes(:ingredients_associations).where("ingredients_associations.ingredient_id IN (?)", ingredients_array.try(:map, &:id) || ingredients_array)
  }

  attr_accessor :_ingredient_names
  def ingredient_names
    return _ingredient_names || self.ingredients_associations.map{|ingredients_association| "#{ingredients_association.ingredient.name}:#{ingredients_association.association_type.name}"}.join(",")
  end

  def ingredient_names=(names)
    array = names.split(",")

    # if you are editing an exsisting salad you must recreate everything
    Rails.logger.info self.id
    if self.id?
      self.ingredients_associations.delete_all
    end

    # for every string present in the array
    for string in array
      # get the ingredient name
      ingredient_name = string.split(":")[0]
      # get the association type name # if present
      association_type_name = string.split(":")[1]

      # create or find the ingredient by its name
      ingredient = Ingredient.find_or_create_by!(name: ingredient_name)
      # create or find the association_type by its name
      association_type = AssociationType.find_or_create_by!(name: association_type_name)

      # Create a new ingredient association
      ingredients_association = IngredientsAssociation.new()
      # Assign the ingredient
      ingredients_association.ingredient = ingredient
      # Assign the salad
      ingredients_association.salad = self
      # Assign the association type
      ingredients_association.association_type = association_type

      ingredients_association.save
    end

    self._ingredient_names = names
  end
end
