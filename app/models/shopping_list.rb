class ShoppingList < ActiveRecord::Base
  has_many :list_items, dependent: :destroy, foreign_key: "list_id"
  has_many :products, through: :list_items
  has_many :list_users, dependent: :destroy, foreign_key: "list_id"
  has_many :users, through: :list_users

  def total_current_amount
    list_items.inject(0){ |sum, item| sum + item.quantity * item.product.price}
  end
end
