class CartsController < ApplicationController
  def show
    @cart = current_user.cart
  end
end
