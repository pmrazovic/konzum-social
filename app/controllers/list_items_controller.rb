class ListItemsController < ApplicationController

  def create
    shopping_list = ShoppingList.find(session[:active_shopping_list])
    pid = params[:product_id]
    item = shopping_list.list_items.find_by_product_id(pid)
    if item
      item.quantity += 1
    else
      item = shopping_list.list_items.build(user_id: current_user, product_id: pid, quantity: 1)    
    end
    respond_to do |format|
      if item.save
        format.html { redirect_to :back, :notice => 'Item was successfully added.' }
        format.js {@current_item = item}
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    item = ListItem.find(params[:id])
    item.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Item deleted.' }
      format.json { head :ok }
      format.js
    end
  end

end