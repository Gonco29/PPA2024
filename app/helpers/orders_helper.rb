module OrdersHelper
  def calculate_order_total(cart_items)
    cart_items.sum do |_, item_details|
      item_details["quantity"].to_i * item_details["price"].to_f
    end
  end
end
