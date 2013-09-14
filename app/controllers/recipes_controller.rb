class RecipesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :modify_ingredients]
  before_action :set_cart

  def new
    @recipe = current_user.recipes.build
    @recipe.save
  end


  def update
    params_recipe = params.require(:recipe).permit(:name, :instructions)
    @recipe.update(params_recipe)
    @recipe.save
    session[:active_recipe] = nil
    redirect_to recipes_dashboard_index_url
  end

  def modify_ingredients
    name = 'temp' #params[name: name]
    instructions = 'temp'
    @recipe.update(name: name, instructions: instructions)
    @recipe.save
    session[:active_recipe] = @recipe.id
    redirect_to categories_url
  end

  def destroy
    if params[:purge]
      @recipe.ingredients.destroy_all
      redirect_to edit_recipe_url
    else
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
