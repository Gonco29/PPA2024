class CartsController < ApplicationController
  def show
    @cart = current_user.cart
    @cart_items = @cart.cart_items
  end
end
