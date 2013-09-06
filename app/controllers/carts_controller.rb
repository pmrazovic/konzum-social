class CartsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @cart = current_cart
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Your cart is currently empty' }
      format.json { head :ok }
    end
  end

  def checkout 
    @cart = Cart.find(params[:id])
    @order = Order.new(:user => current_user)
    @order.add_products(@cart)
    @order.save
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Thank you for your order.' }
      format.json { head :ok }
    end

  end

end