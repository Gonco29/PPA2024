class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  # validates :quantity, presence: true, numericality: { greater_than: 0 }

  before_save :set_default_quantity

  def item_price
    product.current_price * quantity
  end

  private

  def set_default_quantity
    self.quantity ||= 0
  end
end
