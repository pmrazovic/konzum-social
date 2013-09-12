class Like < ActiveRecord::Base
  belongs_to :likeable, :polymorphic => true

  def product
    Product.find_by_id(likeable_id)
  end
end