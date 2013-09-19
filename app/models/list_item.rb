class ListItem < ActiveRecord::Base
  belongs_to :list, class_name: 'ShoppingList', foreign_key: "list_id"
  belongs_to :product
  belongs_to :user
end
