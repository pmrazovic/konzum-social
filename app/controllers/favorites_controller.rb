class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @new_favorite = Favorite.new(:user_id => current_user.id, 
                                 :product_id => params[:product_id])
    @new_favorite.save

    ProductRecommendationFactor.update_factors(current_user, @new_favorite.product, 8)
    UserActivity.create(:user_id => current_user.id, :feedable_id => @new_favorite.product.id, :feedable_type => 'PRODUCT_FAVORITE')

    respond_to do |format|
      format.html { redirect_to :back, :fav_notice => 'Added to favorites.' }
      format.js {render :action => 'create.js.erb'}
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    product = favorite.product 
    @product_id = favorite.product_id

    ProductRecommendationFactor.update_factors(current_user, favorite.product, -8)

    favorite.destroy
    respond_to do |format|
      format.html { redirect_to :back, :fav_notice => "Product #{ActionController::Base.helpers.link_to product.name, product_path(product)} removed from favorites." }
      format.js {render :action => 'destroy.js.erb'}
    end
  end

end