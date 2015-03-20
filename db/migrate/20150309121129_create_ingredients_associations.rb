class CreateIngredientsAssociations < ActiveRecord::Migration
  def change
    create_table :ingredients_associations do |t|
      t.integer :ingredient_id
      t.integer :salad_id
      t.integer :association_type_id

      t.timestamps
    end
  end
end
