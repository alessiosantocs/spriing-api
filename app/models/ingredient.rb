class Ingredient < ActiveRecord::Base

  # Salas < IngredientsAssociations > Ingredients

  has_many :ingredients_associations
  has_many :salads, through: :ingredients_associations
  validates :name, uniqueness: true


  # Give me only ingredients with this association_type
  scope :with_association_type, lambda {|association_type|
    includes(:ingredients_associations).merge(IngredientsAssociation.with_association_type(association_type))
  }

  # Give me only ingredients found in these salads
  scope :found_in_salads, lambda {|salads=[]|
    includes(:ingredients_associations).merge(IngredientsAssociation.with_salads(salads))
  }

  def name
    self[:name]
  end

  def name=(string)
    self[:name] = string.singularize
  end

  alias_method :salads_used_in, :salads

  # Give me a salad and I'll give you the ingredients_association object
  def ingredients_association(salad)
    IngredientsAssociation.find_by(salad_id: salad.id, ingredient_id: self.id)
  end
end
