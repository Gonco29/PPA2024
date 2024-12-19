class CartsController < ApplicationController
  def show
    @cart = session_cart
    @cart_items = []
    @cart_notice = []

    # Iterar sobre el carrito para validar productos y precios
    @cart.each do |product_id, details|
      product = Product.find_by(id: product_id)

      if product
        # Detectar cambios en el precio actual del producto
        if product.current_price.to_i != details["price"].to_i
          @cart_notice << "El precio de '#{product.name}' ha cambiado. Actualizamos el precio en tu carrito."
          details["price"] = product.current_price
        end

        # Agregar el producto actualizado a la lista del carrito
        @cart_items << OpenStruct.new(
          product: product,
          quantity: details["quantity"],
          price: product.formatted_price
        )
      else
        # Si el producto fue eliminado, quitarlo del carrito y mostrar aviso
        @cart_notice << "El producto '#{details["name"] || "desconocido"}' fue eliminado de la tienda y se quitó de tu carrito."
        @cart.delete(product_id)
      end
    end

    session[:cart] = @cart # Actualizar el carrito en la sesión
  end

  # Acción para agregar un producto al carrito
  def add_to_cart
    session[:cart] ||= {}
    product = Product.find(params[:product_id])

    session[:cart][product.id.to_s] ||= { "quantity" => 0, "price" => product.formatted_price }
    session[:cart][product.id.to_s]["quantity"] += 1

    redirect_to cart_path, notice: "#{product.name} se agregó al carrito."
  end

  # Acción para eliminar un producto del carrito
  def remove_item
    session[:cart]&.delete(params[:product_id])
    redirect_to cart_path, notice: "Producto eliminado del carrito."
  end

  private

  # Método para obtener el carrito desde la sesión
  def session_cart
    session[:cart] ||= {}
  end
end
