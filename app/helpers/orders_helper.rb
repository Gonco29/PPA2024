module OrdersHelper
  def calculate_order_total(cart_items)
    cart_items.sum { |item| item.product.price * item.quantity }
  end
end
