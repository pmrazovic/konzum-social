class ShoppingListsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy, :add_all_to_cart]
  before_action :set_cart

  def show
    session[:active_recipe] = nil
  end

  def new
    lu = current_user.list_users.build
    lu.save
    @list = lu.lists.build
    puts @list
    puts "--------------------------------------"
    @list.save
    puts @list

    session[:active_shopping_list] = @list.id
    session[:active_recipe] = nil
  end

  def edit
    session[:active_shopping_list] = @list.id
    session[:active_recipe] = nil
  end

  def update
    params_list = params.require(:shopping_list).permit(:name, :comment)
    if params[:save]
      @list.update(params_list)
      @list.save
      session[:active_shopping_list] = nil
      redirect_to shopping_lists_dashboard_index_url
    elsif params[:modify_items]
      @list.update(params_list)
      @list.save
      redirect_to categories_url
    end    
  end

  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = ShoppingList.find(params[:id])
  end

  def set_cart
    @cart = current_cart
  end  
end
