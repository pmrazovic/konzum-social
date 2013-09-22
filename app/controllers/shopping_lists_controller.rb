class ShoppingListsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy, :add_all_to_cart]
  before_action :set_cart

  def show
  end

  def new
    @list = current_user.shopping_lists.build
    @list.save
    session[:active_list] = @list.id
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @list = ShoppingList.find(params[:id])
  end

  def set_cart
    @cart = current_cart
  end  
end
