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

    @order.products.each{|product| ProductRecommendationFactor.update_factors(current_user, product, 10)}
    UserActivity.create(:user_id => current_user.id, :feedable_id => @order.id, :feedable_type => 'ORDER_CHECKOUT')

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Thank you for your order.' }
      format.json { head :ok }
    end

  end

end