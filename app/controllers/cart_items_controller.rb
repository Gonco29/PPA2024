
# CartItemsController
class CartItemsController < ApplicationController
  # Método para agregar un producto al carrito
  def create
    @cart = session_cart
    product_id = params[:product_id].to_s

    if @cart.key?(product_id)
      @cart[product_id]["quantity"] += params[:quantity].to_i
    else
      product = Product.find(product_id)
      @cart[product_id] = {
        "product_id" => product.id,
        "quantity" => params[:quantity].to_i,
        "name" => product.name,
        "price" => product.current_price
      }
    end

    session[:cart] = @cart
    redirect_to cart_path, notice: 'Producto agregado al carrito'
  end

  # Método para eliminar un producto del carrito
  def destroy
    @cart = session_cart
    product_id = params[:id].to_s

    if @cart.key?(product_id)
      @cart.delete(product_id)
      session[:cart] = @cart
      respond_to do |format|
        format.html { redirect_to cart_path, notice: 'Producto eliminado del carrito' }
        format.json { head :no_content }
      end
    else
      redirect_to cart_path, alert: 'No se pudo eliminar el producto del carrito'
    end
  end

  # Método para actualizar la cantidad de un producto en el carrito
  def update
    @cart = session_cart
    product_id = params[:id].to_s

    if @cart.key?(product_id)
      @cart[product_id]["quantity"] = params[:quantity].to_i
      session[:cart] = @cart
      redirect_to cart_path, notice: 'Carrito actualizado'
    else
      redirect_to cart_path, alert: 'No se pudo actualizar el carrito'
    end
  end

  private

  def session_cart
    session[:cart] ||= {}
  end
end
