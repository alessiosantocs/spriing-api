class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :salad
end
