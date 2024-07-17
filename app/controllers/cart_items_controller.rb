class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart || Cart.create(user: current_user)
    @product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: @product.id)
    @cart_item.quantity ||= 0
    @cart_item.quantity += params[:quantity].to_i

    if @cart_item.save
      redirect_to cart_path, notice: 'Producto agregado al carrito'
    else
      redirect_to product_path(@product), alert: 'No se pudo agregar el producto al carrito'
    end
  end

  def update
    @cart_item = current_user.cart.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Carrito actualizado'
    else
      redirect_to cart_path, alert: 'No se pudo actualizar el carrito'
    end
  end

  def destroy
    @cart_item = current_user.cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Producto eliminado del carrito'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
