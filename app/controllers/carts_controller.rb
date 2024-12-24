class CartsController < ApplicationController
  def show
    @cart = session_cart
    @cart_items = []
    @cart_notice = []

    @cart.each do |product_id, details|
      product = Product.find_by(id: product_id)

      if product
        # Detectar cambios en el precio actual del producto
        if product.price != details["price"].to_i
          @cart_notice << "El precio de '#{product.name}' ha cambiado. Actualizamos el precio en tu carrito."
          details["price"] = product.price
        end

        # Agregar el producto actualizado a la lista del carrito
        @cart_items << OpenStruct.new(
          product: product,
          quantity: details["quantity"].to_i,
          price: details["price"].to_i # Asegurarse de que sea entero
        )
      else
        # Si el producto fue eliminado
        @cart_notice << "El producto '#{details["name"] || "desconocido"}' fue eliminado de la tienda y se quitó de tu carrito."
        @cart.delete(product_id)
      end
    end

    session[:cart] = @cart
  end

  def add_to_cart
    session[:cart] ||= {}
    product = Product.find(params[:product_id])

    session[:cart][product.id.to_s] ||= { "quantity" => 0, "price" => product.price }
    session[:cart][product.id.to_s]["quantity"] += 1

    redirect_to cart_path, notice: "#{product.name} se agregó al carrito."
  end

  def remove_item
    session[:cart]&.delete(params[:product_id])
    redirect_to cart_path, notice: "Producto eliminado del carrito."
  end

  private

  def session_cart
    session[:cart] ||= {}
  end
end
