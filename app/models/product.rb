class Product < ActiveRecord::Base
  has_many :categories_products
  has_many :cart_items
  has_many :order_items
  has_and_belongs_to_many :categories
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :product_recommendation_factor, :dependent => :destroy
  has_many :user_activities, :as => :feedable, :dependent => :destroy

  def bought_by_user?(user)
    user.bought_products.include?(self)
  end

  def bought_by
    User.all.select{|user| user.bought_products.include?(self)}
  end

  def bought_by_friends(user)
    user.friends.select{|friend| bought_by_user?(friend)}
  end

  def liked_by_user?(user)
    user.liked_products.include?(self)
  end

  def liked_by
    User.all.select{|user| user.liked_products.include?(self)}
  end

  def liked_by_friends(user)
    user.friends.select{|friend| liked_by_user?(friend)}
  end

  def favorized_by_user?(user)
    user.favorized_products.include?(self)
  end

  def favorized_by
    User.all.select{|user| user.favorized_products.include?(self)}
  end

  def favorized_by_friends(user)
    user.friends.select{|friend| favorized_by_user?(friend)}
  end

  def leaf_category
    categories.select{|c| c.children.blank?}.first
  end
end