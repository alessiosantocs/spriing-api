class AssociationType < ActiveRecord::Base
  has_many :ingredients_associations
  has_many :ingredients, through: :ingredients_associations
end
