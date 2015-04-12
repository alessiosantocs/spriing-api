class AddUserIdToSalads < ActiveRecord::Migration
  def change
    add_column :salads, :user_id, :integer
  end
end
