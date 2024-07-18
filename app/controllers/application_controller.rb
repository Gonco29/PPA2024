class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_cart_items_count

  include Pundit


  private

  def set_cart_items_count
    if user_signed_in?
      @cart_items_count = current_user.cart.cart_items.sum(:quantity)
    else
      @cart_items_count = 0
    end
  end
end
