# CartsController
class CartsController < ApplicationController
  def show
    @cart = session_cart
    @cart_items = []

    # Iterar sobre el hash del carrito para convertir cada item en un OpenStruct
    @cart.each do |product_id, details|
      product = Product.find_by(id: product_id)
      if product
        @cart_items << OpenStruct.new(
          product: product,
          quantity: details["quantity"],
          price: details["price"]
        )
      end
    end
  end

  private

  # Método para obtener el carrito desde la sesión
  def session_cart
    session[:cart] ||= {}
  end
end
