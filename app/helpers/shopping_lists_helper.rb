module ShoppingListsHelper

  def get_active_list
    list_id = session[:active_shopping_list]
    return ShoppingList.find(list_id)
  end
  
end
