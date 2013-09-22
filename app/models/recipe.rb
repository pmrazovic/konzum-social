class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients

  def total_current_amount
    ingredients.inject(0){ |sum, item| sum + item.quantity * item.product.price}
  end
end
