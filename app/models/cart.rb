class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :destroy
  belongs_to :user

  def add_product(product_id)
    current_item = cart_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
      current_item.save
    else
      current_item = CartItem.create(:product_id => product_id, :cart_id => id, :quantity => 1)
    end
    current_item
  end

  def total_amount
    sum = 0
    cart_items.each{|item| sum += (item.quantity * item.product.price) }
    return sum
  end
end