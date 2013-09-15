class UserActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :feedable, :polymorphic => true

  def product
    Product.find_by_id(feedable_id)
  end

  def order
    Order.find_by_id(feedable_id)
  end

end