class ShoppingListsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy, :add_all_to_cart, :invite]
  before_action :set_cart

  def show
    session[:active_recipe] = nil
  end

  def new
    @list = current_user.shopping_lists.build
    @list.save
    list_user = current_user.list_users.build(list_id: @list.id)
    list_user.save
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
    if params[:purge]
      @list.list_items.destroy_all
      redirect_to edit_shopping_list_url
    else
      if session[:active_shopping_list] == @list.id
        session[:active_shopping_list] = nil
      end
      @list.destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Shopping List destroyed.' }
        format.json { head :ok }
      end
    end    
  end

  def add_all_to_cart
    @list.list_items.each do |item|
      cart_item = current_cart.add_product(item.product.id)
      cart_item.quantity += item.quantity - 1 
      cart_item.save
    end
    redirect_to :back
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
