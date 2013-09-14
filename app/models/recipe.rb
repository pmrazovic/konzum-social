class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients
end
