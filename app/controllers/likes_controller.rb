require 'publisher'

class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @new_like = Like.new(:user_id => current_user.id, 
                        :likeable_id => params[:likeable_id], 
                        :likeable_type => params[:likeable_type])
    @new_like.save

    ProductRecommendationFactor.update_factors(current_user, @new_like.product, 5) if @new_like.likeable_type == 'PRODUCT'
    UserActivity.create(:user_id => current_user.id, :feedable_id => @new_like.product.id, :feedable_type => 'PRODUCT_LIKE') if @new_like.likeable_type == 'PRODUCT'    

    respond_to do |format|
      format.html { redirect_to :back, :like_notice => 'Item liked.' }
      format.js {render :action => 'create.js.erb'}
    end
  end

  def destroy
    like = Like.find(params[:id])
    product = nil
    product = like.product if like.likeable_type == "PRODUCT"
    @likeable_id = like.likeable_id
    @likeable_type = like.likeable_type

    ProductRecommendationFactor.update_factors(current_user, like.product, -5) if like.likeable_type == 'PRODUCT'

    like.destroy
    respond_to do |format|
      format.html { redirect_to :back, :like_notice => product.nil? ? 'Item successfuly disliked.' : "Product #{ActionController::Base.helpers.link_to product.name, product_path(product)} successfuly disliked." }
      format.js {render :action => 'destroy.js.erb'}
    end
  end

end