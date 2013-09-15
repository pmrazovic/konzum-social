class ProductRecommendationFactor < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  def self.update_factors(user, product, factor_value)
    user.confirmed_friends.each do |friend|
      recommendation_record = ProductRecommendationFactor.where(:user_id => friend.id, :product_id => product.id).first
      if recommendation_record.blank?
        ProductRecommendationFactor.create(:user_id => friend.id, :product_id => product.id, :factor => factor_value)
      else
        recommendation_record.factor += factor_value
        recommendation_record.save
        recommendation_record.destroy if recommendation_record.factor <= 0
      end
    end
  end
end