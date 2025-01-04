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

    guest_user = User.find_by(email: "guest@example.com") || User.create!(
      email: "guest@example.com",
      password: SecureRandom.hex(8),
      first_name: "Guest",
      last_name: "User",
      address: "No address provided"
    )


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
          # En lugar de mostrar los errores en el formulario, los pasamos a la notificación
          flash.now[:alert] = "Por favor, revisa los errores antes de continuar:\n" +
                              @order.errors.full_messages.join("\n")
          render :new, status: :unprocessable_entity
        end
      end
    rescue => e
      Rails.logger.error("Error al procesar el pedido: #{e.message}")
      flash.now[:alert] = "Hubo un problema al procesar el pedido: #{e.message}"
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:total, :full_name, :email, :phone, :rut)
  end

  def calculate_order_total(cart)
    cart.sum { |_, item_details| item_details["quantity"].to_i * item_details["price"].to_f }
  end

  def session_cart
    session[:cart] ||= {}
  end
end
