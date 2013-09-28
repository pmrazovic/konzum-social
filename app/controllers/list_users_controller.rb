class ListUsersController < ApplicationController

  def show
  end
  
  def create
    @list_user = get_active_list.list_users.build(user_id: params[:user_id])
    @list_user.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render :action => 'refresh.js.erb'}
    end
  end

  def destroy 
    lu = ListUser.find_by(list_id: get_active_list, user_id: params[:user_id])
    lu.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render :action => 'refresh.js.erb'}
    end
  end

  def get_active_list
    list_id = session[:active_shopping_list]
    return ShoppingList.find(list_id)
  end
end
