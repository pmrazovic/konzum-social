class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy

  def add_products(cart)
    cart.cart_items.each do |cart_item|
      order_items.build(:product_id => cart_item.product_id, :quantity => 1)
    end
  end

  def total_current_amount
    order_items.inject(0){ |sum, item| sum + item.quantity * item.product.price}
  end
end