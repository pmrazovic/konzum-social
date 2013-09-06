class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, :dependent => :destroy

  def add_products(cart)
    cart.cart_items.each do |cart_item|
      order_items.build(:product_id => cart_item.product_id, :quantity => 1)
    end
  end
end