class RecipesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :add_all_to_cart]
  before_action :set_cart

  def new
    @recipe = current_user.recipes.build
    @recipe.save
    session[:active_recipe] = @recipe.id
  end

  def show    
  end

  def add_all_to_cart
    @recipe.ingredients.each do |ingredient|
      cart_item = current_cart.add_product(ingredient.product.id)
      cart_item.quantity += ingredient.quantity
      cart_item.save
    end
    redirect_to :back
  end

  def edit
    session[:active_recipe] = @recipe.id
  end

  def update
    params_recipe = params.require(:recipe).permit(:name, :instructions)
    if params[:save]
      @recipe.update(params_recipe)
      @recipe.save
      session[:active_recipe] = nil
      redirect_to recipes_dashboard_index_url
    elsif params[:modify_ingredients]
      @recipe.update(params_recipe)
      @recipe.save
      redirect_to categories_url
    end      
  end


  def destroy
    if params[:purge]
      @recipe.ingredients.destroy_all
      redirect_to edit_recipe_url
    else
      if session[:active_recipe] == @recipe.id
        session[:active_recipe] = nil
      end
      @recipe.destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Recipe destroyed.' }
        format.json { head :ok }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_cart
    @cart = current_cart
  end
end
