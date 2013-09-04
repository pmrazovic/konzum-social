class CartItemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to :back, :notice => 'Item was successfully added.' }
        format.js {@current_item = @cart_item}
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @cart = current_cart
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Item deleted.' }
      format.json { head :ok }
      format.js
    end
  end

end