class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @new_favorite = Favorite.new(:user_id => current_user.id, 
                                 :product_id => params[:product_id])
    @new_favorite.save
    render :action => 'create.js.erb'
  end

  def destroy
    favorite = Favorite.find(params[:id])
    @product_id = favorite.product_id
    favorite.destroy
    render :action => 'destroy.js.erb'
  end

end