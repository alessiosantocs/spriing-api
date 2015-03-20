class SaladBuilderController < ApplicationController
  def index
    # given an ingredient give me the

    redirect_to "/build/base"
  end

  def show
    @association_type = AssociationType.find_by_name(params[:id])

    @previous_ingredients = previous_ingredients

    @suggested_ingredients = get_suggested_ingredients_for(@previous_ingredients, @association_type)
    @conventional_ingredients = Ingredient.with_association_type(@association_type)
  end

  private

  def get_suggested_ingredients_for(chosen_ingredients=[], association_type=nil) #=> Array/ActiveRecord:Relation
    suggested_ingredients = []

    if chosen_ingredients.any?
      salads = Salad.with_ingredients(chosen_ingredients)

      suggested_ingredients = Ingredient.with_association_type(association_type)
                                        .found_in_salads(salads)
                                        .merge(IngredientsAssociation.count_and_sort_by_ingredient_id_occurrences())

    else
      suggested_ingredients = Ingredient.with_association_type(association_type)
                                        .merge(IngredientsAssociation.count_and_sort_by_ingredient_id_occurrences())
                                        .limit(5)
    end
    return suggested_ingredients
  end

  def previous_ingredients
    ingredients = params[:chosen_ingredients] || []
    ingredients += params[:previous_ingredients] || []

    flash[:previous_ingredients] = ingredients

    ingredients_ids = ingredients.map{|elm| elm.split(":").first}

    ingredients = Ingredient.where("ingredients.id IN (?)", ingredients_ids).includes(:ingredients_associations).order("ingredients_associations.association_type_id ASC")

    return ingredients
  end
end
