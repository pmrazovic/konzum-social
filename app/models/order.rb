class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, :dependent => :destroy
  has_many :products, :through => :order_items
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :user_activities, :as => :feedable, :dependent => :destroy
  before_destroy :delete_user_activity

  def add_products(cart)
    cart.cart_items.each do |cart_item|
      order_items.build(:product_id => cart_item.product_id, :quantity => 1)
    end
  end

  def total_current_amount
    order_items.inject(0){ |sum, item| sum + item.quantity * item.product.price}
  end

  def delete_user_activity
    activity = UserActivity.where(:user_id => user.id, :feedable_id => id, :feedable_type => 'ORDER_CHECKOUT').first
    activity.destroy unless activity.nil?
  end
end