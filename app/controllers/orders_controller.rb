# OrdersController
class OrdersController < ApplicationController
  include OrdersHelper

  def new
    @order = Order.new
    @cart = session_cart

    if @cart.empty?
      redirect_to cart_path, alert: "No puedes realizar un pedido con un carrito vacío."
    end
  end

  def create
    @cart = session_cart

    if @cart.empty?
      redirect_to cart_path, alert: "No puedes realizar un pedido con un carrito vacío."
      return
    end

    # Para usuarios no registrados, podemos usar un usuario genérico
    guest_user = User.find_or_create_by(email: "guest@example.com") do |user|
      user.password = SecureRandom.hex(8) # Contraseña aleatoria segura
      user.first_name = "Guest"
      user.last_name = "User"
      user.address = "No address provided" # Asigna algún valor por defecto si este campo es requerido
    end

    @order = Order.new(order_params)
    @order.total = calculate_order_total(@cart)
    @order.user = guest_user

    begin
      Order.transaction do
        if @order.save
          @cart.each do |product_id, item_details|
            @order.order_items.create!(
              product_id: product_id,
              quantity: item_details["quantity"],
              price: item_details["price"]
            )
          end
          session[:cart] = {}
          redirect_to order_path(@order), notice: 'Pedido realizado con éxito'
        else
          flash.now[:alert] = "No se pudo crear el pedido. Por favor, revisa los errores."
          render :new
        end
      end
    rescue => e
      flash.now[:alert] = "Hubo un problema al procesar el pedido: #{e.message}"
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:total)
  end

  def calculate_order_total(cart)
    cart.sum { |_, item_details| item_details["quantity"].to_i * item_details["price"].to_f }
  end

  def session_cart
    session[:cart] ||= {}
  end
end
