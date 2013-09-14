class RecipesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :modify_ingredients]
  before_action :set_cart

  def new
    @recipe = current_user.recipes.build
    @recipe.save
  end

  def update
    @recipe.update(name: params[:name], instructions: params[:instructions])
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

private
  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_cart
    @cart = current_cart
  end
end
