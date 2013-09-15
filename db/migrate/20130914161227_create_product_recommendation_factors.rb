class CreateProductRecommendationFactors < ActiveRecord::Migration
  def change
    create_table :product_recommendation_factors do |t|
      t.references :user
      t.references :product
      t.integer :factor
    end
  end
end
