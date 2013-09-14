class IngredientsController < ApplicationController

  def create
    recipe = Recipe.find(session[:active_recipe])
    pid = params[:product_id]
    ingredient = recipe.ingredients.find_by_product_id(pid)
    if ingredient
      ingredient.quantity += 1
    else
      ingredient = recipe.ingredients.build(product_id: pid, quantity: 1)    
    end
    respond_to do |format|
      if ingredient.save
        format.html { redirect_to :back, :notice => 'Item was successfully added.' }
        format.js {@current_item = ingredient}
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    ingredient.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Item deleted.' }
      format.json { head :ok }
      format.js
    end
  end

end
