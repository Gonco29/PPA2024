class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.total = current_user.cart.cart_items.sum { |item| item.product.price * item.quantity }
    if @order.save
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end
      current_user.cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: 'Pedido realizado con éxito'
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:total)
  end
end
