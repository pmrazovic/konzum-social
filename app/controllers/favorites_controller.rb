class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @new_favorite = Favorite.new(:user_id => current_user.id, 
                                 :product_id => params[:product_id])
    @new_favorite.save
    respond_to do |format|
      format.html { redirect_to :back, :notice => 'Added to favorites.' }
      format.js {render :action => 'create.js.erb'}
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    product = favorite.product 
    @product_id = favorite.product_id
    favorite.destroy
    respond_to do |format|
      format.html { redirect_to :back, :notice => "Product #{ActionController::Base.helpers.link_to product.name, product_path(product)} removed from favorites." }
      format.js {render :action => 'destroy.js.erb'}
    end
  end

end