class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Your order is deleted' }
      format.json { head :ok }
    end
  end
end