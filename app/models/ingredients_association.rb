class IngredientsAssociation < ActiveRecord::Base
  belongs_to :salad
  belongs_to :ingredient

  belongs_to :association_type

  scope :with_association_type, lambda{|association_type|
    where(:association_type_id => association_type.try(:id) || association_type)
  }

  scope :with_salads, lambda{|salads|
    where(:salad_id => salads.try(:map, &:id) || salads)
  }

  scope :count_and_sort_by_ingredient_id_occurrences, group(:ingredient_id).order("COUNT(ingredients_associations.ingredient_id) DESC")
end
