module RecipesHelper

  def get_active_recipe
    recipe_id = session[:active_recipe]
    return Recipe.find(recipe_id)
  end
  
end
