class ApplicationController < ActionController::Base
  before_action :set_cart_items_count

  include Pundit

  private

  # Configuración para contar los elementos en el carrito, basado en la sesión del visitante
  def set_cart_items_count
    if session[:cart].present?
      @cart_items_count = session[:cart].sum { |_, details| details['quantity'] } || 0
    else
      @cart_items_count = 0
    end
  end
end

