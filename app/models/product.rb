class Product < ActiveRecord::Base
  has_many :categories_products
  has_many :cart_items
  has_and_belongs_to_many :categories
end