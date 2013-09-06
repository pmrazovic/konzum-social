class Product < ActiveRecord::Base
  has_many :categories_products
  has_many :cart_items
  has_many :order_items
  has_and_belongs_to_many :categories

  def bought_by_user?(user)
    user.bought_products.include?(self)
  end

  def bought_by
    User.all.select{|user| user.bought_products.include?(self)}
  end

  def bought_by_friends(user)
    user.friends.select{|friend| bought_by_user?(friend)}
  end

end