class ListUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :list,  class_name: 'ShoppingList', foreign_key: "list_id"
end
